class Api::V1::OrderState::OrderStatesController < ApplicationController
  before_action :authenticate_user!

  def show
    order_states = ::OrderState.all
    render json: order_states, :status => :ok
  end

end