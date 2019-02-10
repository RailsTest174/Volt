module Api
  module V1
    class UsersController < Api::V1::BaseController

      def create
        user = User.new(user_params)
        
        if user.save
          render json: user
        else
          render json: user.errors, status: :unprocessable_entity
        end    
      end

      private

      def user_params
        params.permit(:email, :nickname, :password)
      end
      
    end
  end
end