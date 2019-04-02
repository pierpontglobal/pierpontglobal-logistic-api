class Api::V1::Order::OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    token = params[:token]

    # Call PierpontGlobal API with token to get bids
    orders = ::Order.all
    render json: orders, :status => :ok

  end

  def create_shippment
    # Add this option later....
    # commodities = params[:commodities]
    # charges = params[:charges]
    #
    shipp = ::Shippment.create!(order_detail_params)

    check_order = ::Order.where(order_number: params[:order_number])
    order = {}
    if check_order.nil?
      order = create(params[:order_number], shipp[:id])
    else
      order = check_order
    end



    render json: {
        shippment: shipp,
        order: order
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