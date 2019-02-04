class User < ApplicationRecord
  has_many :posts
  has_many :comments

  validates :nuckname , presence: true
  validates :email    , presence: true
  validates :password , presence: true
end
