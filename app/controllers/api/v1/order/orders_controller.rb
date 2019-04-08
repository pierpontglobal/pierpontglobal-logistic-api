class Api::V1::Order::OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    token = params[:token]

    # Call PierpontGlobal API with token to get bids
    orders = ::Order.all.joins!(:shippment).select('orders.order_number, orders.id, shippments.origin_name,
        shippments.service_type, shippments.destination_name')

    ordersWithoutShipp = ::Order.where(:shippment_id => nil)

    render json: {
        orders_with_shipp: orders,
        orders_without_shipp: ordersWithoutShipp
    }, :status => :ok
  end

  def order_shippment
    order = ::Order.joins(:order_state).where(:orders => {
        order_id: params[:id]
    })
    render json: order, status: :ok
  end

  def create_shippment

    order_id = params[:order_number]
    order_params = order_detail_params

    check_shipp = ::Shippment.where(order_number: order_id)[0]
    @order = ::Order.where(order_number: order_id)[0]

    if check_shipp.nil?
      puts 'CREATE SHIPMENT'
      @shipp = ::Shippment.create!(order_params)
    else
      puts 'MODIFY SHIPMENT'
      @shipp = check_shipp
      @shipp.update!(order_params)
    end

    @order.shippment = @shipp
    @order.save!

    render json: {
        shippment: @shipp,
        order: @order
    }, :status => :ok

  end

  # Agents
  # Mode of transportation
  # Issuing company
  # Consignee

  # PATCH: /api/v1/order
  def modify_state
    order = ::Order.find(params[:id])
    order.update!(order_state: OrderState.find(params[:state_id]))
    render json: order, status: :ok
  rescue StandardError => e
    render json: e, status: :bad_gateway
  end

  # TODO: Elastic search
  def detail_options
    consignees = ::Consignee.all
    shippers = ::Shipper.all
    transports = ::ModeOfTransportation.all
    containers = ::Container.all
    issuing_companies = ::IssuingCompany.all
    agents = ::Agent.all

    render json: {
        consignees: consignees,
        shippers: shippers,
        transports: transports,
        containers: containers,
        issuing_companies: issuing_companies,
        agents: agents
    }, :status => :ok
  end


  def create(order_number, shippment_id)
    order = ::Order.create!(
               :order_number => order_number,
               :user_id => current_user.id,
               :shippment_id => shippment_id
              )
    order
  end


  def order_detail_params
    params.require(:order_detail).permit(:order_number, :service_type, :issuing_company_id, :shipper_id,
    :consignee_id, :agent_id, :mode_of_transportation_id, :destination_name,
    :origin_name)
  end


end