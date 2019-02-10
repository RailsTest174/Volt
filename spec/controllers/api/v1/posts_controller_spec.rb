require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  
  context 'show' do
    it 'show post' do
      user = FactoryBot.create(:user)
      request.headers['Authorization'] = user.token
      post = FactoryBot.create(:post)
      serializer = PostSerializer.new(post)

      get :show, params: { id: post.id }

      expect(response.body).to eq(serializer.to_json)
    end
  end

  context 'index' do
    it 'http status 400' do
      get :index, params: {page: 2}
      expect(response.code) == ("400")
    end  
    it 'http status 200' do
      get :index, params: {page: 1, per_page: 8}
      expect(response.code) == ("200")
      expect(response.headers["X-Pages"]) == (1)
      expect(response.headers["X-All_posts"]) == (0)
    end 

    it 'displays all posts' do
      user = FactoryBot.create(:user)
      request.headers['Authorization'] = user.token
      post_one = FactoryBot.create(:post)
      post_two = FactoryBot.create(:post)

      posts = Post.latest
      serializer = ActiveModelSerializers::SerializableResource.new(posts)
      get :index

      expect(response.body) == (serializer.to_json)
    end
  end

  context 'create' do
    it 'save post' do
      post = FactoryBot.create(:post)

      expect(post.valid?).to eq(true)
    end
  end  

end
