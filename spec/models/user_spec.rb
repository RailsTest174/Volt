require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validation tests' do
    
    it 'nickname presence' do
      user = User.create(email: 'ab@mail.ru', password: '123123')
      expect(user.errors.include?(:nickname)).to eq(true)
    end

    it 'email presence' do
      user = User.create(nickname: 'name', password: '123123')
      expect(user.errors.include?(:email)).to eq(true)
    end

    it 'password presence' do
      user = User.create(nickname: 'name', email: 'ab@mail.ru')
      expect(user.errors.include?(:password)).to eq(true)
    end

    it 'must be created' do
      user = FactoryBot.create(:user)
      expect(user.valid?).to eq(true)
    end
  end

  context 'private methods' do
    it 'token generated' do
      user = FactoryBot.create(:user)
      expect(user.token.empty?).to eq(false)
    end
  end

end