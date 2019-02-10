module Api
  module V1
    class PostsController < Api::V1::BaseController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      include Pagy::Backend
      before_action :authenticate_user!

      def index
        return render status: :bad_request unless params[:per_page].present? && params[:page].present?

        pagy, posts = pagy(Post.latest, items: params[:per_page], page: params[:page])
        response.set_header('X-Pages', pagy.pages)
        response.set_header('X-All_posts', pagy.count)

        render json: posts
      end

      def show
        post = Post.find(params[:id])

        render json: post
      end

      def create
        post = current_user.posts.new(post_params)
        post.published_at = Time.now if post.published_at.blank?

        if post.save
          render json: post, status: :created
        else
          render json: post.errors, status: :unprocessable_entity
        end    
      end

      private

      def post_params
        params.permit(:title, :body, :published_at)
      end
    end
  end
end