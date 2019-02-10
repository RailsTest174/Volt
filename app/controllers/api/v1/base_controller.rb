module Api
  module V1
    class BaseController < ApplicationController
      def current_user
        @current_user ||= User.find_by(token: request.headers['Authorization']) if request.headers['Authorization'].present?
      end

      def authenticate_user!
        render json: { error: 'Not Authorized' }, status: 401 unless current_user
      end
    end
  end
end