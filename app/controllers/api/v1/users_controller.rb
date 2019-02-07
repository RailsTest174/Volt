module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all

        render json: users
      end

      def show
        user = User.find_by(params[:id])

        render json: user
      end

      def create
        user = User.new(user_params)
        
        if user.save
          render status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end    
      end

      private

      def user_params
        params.require(:user).permit(:email, :nickname, :password)
      end
    end
  end
end