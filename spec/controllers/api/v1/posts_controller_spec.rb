require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  context 'show' do
    xit 'disp' do
      user = User.create(nickname: 'kek', email: 'aaa@aa.com', password: 123123123)
      post = Post.create(title: 'title', body: 'body', user: user, published_at: Time.now)
      serializer = PostSerializer.new(post)

      get :show, params: { id: post.id }

      expect(response.body).to eq(serializer.to_json)
    end
  end

  context 'index' do
    it '400' do
      get :index, params: {page: 2}
      expect(response.code).to eq("400")
    end  
    it '200' do
      get :index, params: {page: 1, per_page: 8}
      expect(response.code).to eq("200")
      expect(response.headers["X-Pages"]).to eq(1)
      expect(response.headers["X-Count"]).to eq(0)
    end 

    xit 'all' do
      user = User.create(nickname: 'kek', email: 'aaa@aa.com', password: 123123123)
      post = Post.create(title: 'title', body: 'body', user: user, published_at: Time.now)
      post_2 = Post.create(title: 'title2', body: 'body2', user: user, published_at: Time.now)

      user = create(:user)
      post = create(:post, user: user)
      post_2 = create(:post, user: user)

      posts = Post.latest
      serializer = ActiveModel::SerializableResource.new(posts)
      get :index

      expect(response.body).to eq(serializer.to_json)
    end
  end

end
