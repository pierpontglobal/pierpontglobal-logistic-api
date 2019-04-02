class Api::V1::Order::OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    token = params[:token]

    # Call PierpontGlobal API with token to get bids
    orders = ::Order.all
    render json: orders, :status => :ok

  end

  def create_shippment
    detail = order_detail_params

    # Add this option later....
    # commodities = params[:commodities]
    # charges = params[:charges]

    shipp = ::Shippment.first_or_create!(order_detail_params)
    order = create(shipp.order_number, shipp.id)

    render json: {
        shippment: shipp,
        order: order
    }, :status => :ok


  end


  def create(order_number, shippment_id)
    order = ::Order.first_or_create!(
               :order_number => order_number,
               :user_id => current_user.id,
               :shippment_id => shippment_id
    )
    order
  end


  def order_detail_params
    params.require('order_detail').permit('order_number, service_type, date, issuing_company_id, shipper_id,
    consignee_id, agent_id, mode_of_transportation_id, destination_name,
    origin_name')
  end


end