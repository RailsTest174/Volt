require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  context 'show' do
    it 'show post' do
      post = create(:post)
      serializer = PostSerializer.new(post)

      get :show, params: { id: post.id }

      expect(response.body).to eq(serializer.to_json)
    end
  end

  context 'index' do
    it 'http status 400' do
      get :index, params: {page: 2}
      expect(response.code).to eq("400")
    end  
    it 'http status 200' do
      get :index, params: {page: 1, per_page: 8}
      expect(response.code).to eq("200")
      expect(response.headers["X-Pages"]).to eq(1)
      expect(response.headers["X-All_posts"]).to eq(0)
    end 

    it 'displays all posts' do
      post = create(:post)
      post_2 = create(:post)

      posts = Post.latest
      serializer = ActiveModel::SerializableResource.new(posts)
      get :index

      expect(response.body).to eq(serializer.to_json)
    end
  end

end
