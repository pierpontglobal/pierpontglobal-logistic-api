module Api
  module V1
    class BaseApiController < ApplicationController
      before_action :authenticate_user!

      def test
        render json: 'All good', status: :ok
      end
    end
  end
end