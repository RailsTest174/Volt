class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body,  presence: true

  scope :latest, -> { order(published_at: :desc) }
end
