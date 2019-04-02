class Api::V1::Shipper::ShippersController < ApplicationController
  before_action :authenticate_user!

  def create
    render json: ::Shipper.where(shippers_parameters)
                     .first_or_create!,
           status: :ok
  end

  def show
    render json: ::Shipper.all.sanitized, status: :ok
  end


  def shippers_parameters
    params.require('shipper').permit('name', 'address', 'location', 'custom_name', 'city', 'vicinity', 'place_id')
  end
end