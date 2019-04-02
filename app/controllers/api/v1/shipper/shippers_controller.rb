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


  def show_by_id
    if params[:id].present?
      shipp = ::Shipper.find(params[:id])
      render json: shipp, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end
  end

  def update
    if params[:id].present?
      result = ::Shipper.where(:id => params[:id]).update!(shippers_parameters)
      render json: result, :status => :ok
    end
  end

  def delete
    if params[:id].present?
      result = ::Shipper.find(params[:id]).destroy
      render json: result, :status => :ok
    end
  end


  def shippers_parameters
    params.require('shipper').permit('name', 'address', 'location', 'custom_name', 'city', 'vicinity', 'place_id')
  end
end