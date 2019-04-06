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

      if @shipp.present?

        commodities = ::Commodity.where(:shippment_id => @shipp.id)
        return_array = []

        if commodities.any?
          commodities.each do |commodity|
            type = commodity[:commodity_type_id]
            reference = commodity[:reference]

            if type == 1
              find_result = get_car_info(reference)
              if find_result['error'].present?
                # Error retrieving car, do not show!
              else
                return_array.append({:commodity => commodity, :artifact => find_result})
              end
            elsif type == 2
              find_result = get_container_info(reference)
              find_result['id'] = reference # Warning, this is important for the front end
              if find_result['error'].present?
                # Error retrieving car, do not show!
              else
                return_array.append({:commodity => commodity, :artifact => find_result})
              end
            end
          end
        end

        puts return_array.inspect

        render json: {
            commodities: return_array,
            shippment_detail: @shipp,
        }, :status => :ok
      else
        render json: nil, :status => :ok
      end

    else
      render json: {
          error: "Please, provide an id"
      }, status: :bad_request
    end
  end

  def get_container_info(id)
    container = ::Container.find(id).dup
    return container
  end

  def get_car_info(vin)

    sk = ENV['PIERPONTGLOBAL_SK']
    pk = ENV['PIERPONTGLOBAL_PK']

    url = URI("#{ENV['PIERPONTGLOBAL_URL']}/oauth/cars/#{vin}")
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    request["Content-Type"] = 'application/json'
    request.body = "{\n\t\"pk\": \"#{pk}\",\n\t\"sk\": \"#{sk}\",\n\t\"uuid\": \"#{current_user.uuid}\"\n}"
    response_data = http.request(request)
    car = JSON.parse(response_data.body)

    return car
  end


  def shippments_parameters
    params.require('shippment').permit('order_number', 'service_type', 'destination_name', 'origin_name',
                                       'issuing_company_id', 'consignee_id', 'shipper_id', 'agent_id',
                                       'mode_of_transportation_id')
  end
end