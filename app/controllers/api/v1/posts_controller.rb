module Api
  module V1
    class PostsController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      include Pagy::Backend
      before_action :authenticate, only: [:create, :destroy]

      def index
        return render status: :bad_request unless params[:per_page].present? && params[:page].present?

        pagy, posts = pagy(Post.latest, items: params[:per_page], page: params[:page])
        response.set_header('X-Pages', pagy.pages)
        response.set_header('X-Count', pagy.count)

        render json: posts
      end

      def show
        post = Post.find(params[:id])

        render json: post
      end

      def create
        post = user.posts.new(post_params)
        post.published_at = Time.now if @post.published_at.empty?

        if post.save
          render json: post, status: :created
        else
          render json: post.errors, status: :unprocessable_entity
        end    
      end

      def destroy
        post = user.post.find_by(params[:id])

        if post
          post.destroy
        else
          render json: { post: "not found" }, status: :not_found
        end
      end

      private

      def post_params
        params.permit(:title, :body, :published_at)
      end

      def authenticate
        authenticate_or_request_with_http_token do |token, options|
          user = User.find_by(token: token)
        end
      end
      
    end
  end
end