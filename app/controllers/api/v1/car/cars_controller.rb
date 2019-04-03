class Api::V1::Car::CarsController < ApplicationController
  before_action :authenticate_user!

  def show
    vin = params[:vin]

    sk = ENV['PIERPONTGLOBAL_SK']
    pk = ENV['PIERPONTGLOBAL_PK']

    url = URI("#{ENV['PIERPONTGLOBAL_URL']}/oauth/cars/#{vin}")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    request["Content-Type"] = 'application/json'
    puts " >> >>> >>>>>>>>>  >>>>  #{current_user.uuid}"
    puts sk
    puts pk
    request.body = "{\n\t\"pk\": \"#{pk}\",\n\t\"sk\": \"#{sk}\",\n\t\"uuid\": \"#{current_user.uuid}\"\n}"

    puts "will call rhtpp request >>> "
    response_data = http.request(request)
    puts response_data
    car = JSON.parse(response_data.body)
    render json: car, status: :ok
  end
end
