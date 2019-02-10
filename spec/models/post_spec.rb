require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'validation tests' do

    it 'title presence' do
      post = Post.create(body: 'Text')
      expect(post.errors.include?(:title)).to eq(true)
    end

    it 'body presence' do
      post = Post.create(title: 'Title')
      expect(post.errors.include?(:body)).to eq(true)
    end

    it 'should save successfully' do
      post = FactoryBot.create(:post)
      expect(post.errors.size).to eq(0)
    end

  end

  context 'scopes' do
    it 'must be ordered by published DESC' do
      post_one = FactoryBot.create(:post, published_at: 5.minutes.ago)
      post_two = FactoryBot.create(:post, published_at: 2.minutes.ago)
      
      posts = Post.all

      expect(posts.order('published_at desc').to_a).to eq([post_two, post_one])
    end

  end

end
