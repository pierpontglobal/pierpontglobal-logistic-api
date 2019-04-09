class Api::V1::OrderState::OrderStatesController < ApplicationController

  def show
    order_states = ::OrderState.all
    render json: order_states, :status => :ok
  end

end