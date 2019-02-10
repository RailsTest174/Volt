class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :email, :token
end