class ApplicationController < ActionController::API

  def health
    render json: {message: 'healthy'}, status: :ok
  end

end
