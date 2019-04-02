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

  def showByOrderNumber
    if params[:order_number].present?
      @shipp =  ::Shippment.where(:order_number => params[:order_number])
                    .joins!(:consignee, :agent, :mode_of_transportation, :shipper, :issuing_company)
                    .select('shippments.*, consignees.name as consignee_name, consignees.address as consignee_address',
                    'agents.name as agent_name', 'agents.address as agent_address', 'shippers.name as shipper_name',
                    'shippers.address as shipper_address', 'shippers.location as shipper_location', 'shippers.place_id as shipper_place_id',
                    'shippers.city as shipper_city', 'shippers.vicinity as shipper_vicinity',
                    'issuing_companies.company_name as issuing_company_name', 'issuing_companies.company_location as issuing_company_location',
                    'mode_of_transportations.name as mode_of_transportation_name')[0]

      render json: @shipp, :status => :ok

    else
      render json: {
          error: "Please, provide an id"
      }, status: :bad_request
    end
  end


  def shippments_parameters
    params.require('shippment').permit('order_number', 'service_type', 'destination_name', 'origin_name',
                                       'issuing_company_id', 'consignee_id', 'shipper_id', 'agent_id',
                                       'mode_of_transportation_id')
  end
end