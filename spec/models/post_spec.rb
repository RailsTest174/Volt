require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validation tests' do
    it 'title presence' do
      post = Post.new(body: 'Text').save
      expect(post).to eq(false)
    end

    it 'body presence' do
      post = Post.create(title: 'Title')
      expect(post.errors.include?(:body)).to eq(true)
    end

    it 'should save successfully' do
      post = create(:post)
      expect(post.errors.size).to eq(0)
    end  
  end

  context 'scopes' do
    describe 'published_at' do
      xit 'must be ordered by published DESC'
        post = create(:post)
        post_2 = create(:post)
        post_3 = create(:post)
    end
  end

end
