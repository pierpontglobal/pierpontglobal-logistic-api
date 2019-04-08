class Api::V1::Commodity::CommoditiesController < ApplicationController
  before_action :authenticate_user!


  def create
    commodity_params = commodity_parameters
    if params[:order_number].present?
      @shipp =  ::Shippment.where(:order_number => params[:order_number])[0]
      if @shipp.present?
        commodity_type = ::CommodityType.where(:custom_id => commodity_params[:type])[0]

        if commodity_type.present?
          commodity = ::Commodity.create!(:reference => commodity_params[:reference],
                                          :pieces => commodity_params[:pieces], :shippment_id => @shipp.id,
                                          :commodity_type_id => commodity_type[:id])

          artifact = nil
          if commodity_type[:custom_id] == 1

            artifact = get_car_info(commodity[:reference])

          elsif commodity_type[:custom_id] == 2

            artifact = get_container_info(commodity[:reference])

          end

          if artifact == nil or artifact['status'] == 500
            render json: {
                error: "Couldn't associate artifact in response."
            }, :status => :internal_server_error

          else
            render json: {
                commodity: commodity,
                artifact: artifact
            }, :status => :ok
          end

        else
          render json: {
              error: "No commodity type found with the 'type' parameters sent."
          }, :status => :ok
        end

      else
        render json: {
            error: "Shippment associated with this order couldn't be found."
        }, :status => :not_found
      end

    else
      render json: {
          error: "Please provide an order number"
      }, :status => :bad_request
    end
  end

  def update
    if params[:pieces].present?
      comodity = ::Commodity.update!(:pieces => params[:pieces])
      render json: {
          commodity: comodity
      }, :status => :ok
    else
      render json: {
          error: "Please provide a pieces to modify."
      }, :status => :bad_request
    end
  end

  def delete
    if params[:reference].present? and params[:shipp_id].present?
      commodity = ::Commodity.find_by(:id => params[:reference], :shippment_id => params[:shipp_id])
      puts commodity.inspect
      puts params[:reference]
      puts params[:shipp_id]
      if commodity.present?
        ::Commodity.destroy(commodity[:id])
        render json: {
            commodity: commodity
        }, :status => :ok
      else
        render json: {
            error: "couldn't find the commodity"
        }, :status => :not_found
      end
    else
      render json: {
          error: "Please provide reference and shippment ID."
      }, :status => :bad_request
    end
  end

  def get_container_info(id)
    container = ::Container.find(id)
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

  def commodity_parameters
    params.require('commodity').permit('reference', 'pieces', 'type')
  end
end