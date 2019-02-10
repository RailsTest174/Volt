require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  context 'create' do
    it 'create and render' do
      user = FactoryBot.create(:user)
      serializer = ActiveModelSerializers::SerializableResource.new(user)
      post :create, params: {nickname: user.nickname, email: user.email, password: user.password, token: user.token}
      expect(response.body) == (serializer.to_json)
    end  
  end 

end