class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author_nickname, :published_at

  def author_nickname
    object.user.nickname
  end
end