class Api::V1::Shippment::ShippmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    render json: ::Shippment.where(shippers_parameters)
                     .first_or_create!,
           status: :ok
  end

  def show
    render json: ::Shippment.all.sanitized, status: :ok
  end


  def shippments_parameters
    params.require('shippment').permit('order_number', 'service_type', 'destination_name', 'origin_name',
                                       'issuing_company_id', 'consignee_id', 'shipper_id', 'agent_id',
                                       'mode_of_transportation_id')
  end
end