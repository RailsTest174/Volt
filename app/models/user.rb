class User < ApplicationRecord
  before_create -> {self.token = generate_token}

  has_many :posts
  has_many :comments

  validates :nickname , presence: true
  validates :email    , presence: true
  validates :password , presence: true

  private

  def generate_token
    loop do
      token = SecureRandom.hex
      return token unless User.exists?({token: token})
    end  
  end

end
