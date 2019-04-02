require 'uri'
require 'net/http'

class ApplicationController < ActionController::API

  def health
    render json: {message: 'healthy'}, status: :ok
  end

  def new_oauth_session
    toke = params[:token]
    sk = ENV['PIERPONTGLOBAL_SK']
    pk = ENV['PIERPONTGLOBAL_PK']

    url = URI("#{ENV['PIERPONTGLOBAL_URL']}/oauth/user")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = 'application/json'
    request.body = "{\n\t\"pk\": \"#{pk}\",\n\t\"sk\": \"#{sk}\",\n\t\"token\": \"#{toke}\"\n}"

    response_data = http.request(request)
    user_info = JSON.parse(response_data.body)

    user = User.find_by(uuid: user_info['id'], provider: 'PPG')
    if user
      token = Warden::JWTAuth::UserEncoder.new.call(user, 'user', nil)[0]
    else
      user = User.create!(
        uuid: user_info['id'],
        provider: 'PPG',
        email: user_info['email']
      )
      token = Warden::JWTAuth::UserEncoder.new.call(user, 'user', nil)[0]
    end

    response.set_header('Authorization', "Bearer #{token}")
    render json: response_data.body, status: :ok
  rescue
    render json: 'Something went wrong check credentials', status: :unauthorized
  end
  
  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
        errors: [
            {
                status: '400',
                title: 'Bad Request',
                detail: resource.errors,
                code: '100'
            }
        ]
    }, status: :bad_request
  end

end
