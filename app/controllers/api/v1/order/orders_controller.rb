class Api::V1::Order::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: ::Order.all, status: :ok
  end

  def get_order_shippment
    orders = ::Order.includes(:shippment)
    order = orders.find(params[:id])
    render json: order, status: :ok
  end

  def add_shippment

    obj = {
        order_id: params['id'],
        message: 'it works'
    }

    if params['id'] == nil
      obj = {
          order_id: params['id'],
          message: 'Please, provide an id'
      }
    end

    render json: obj, statis: :ok
  end

end