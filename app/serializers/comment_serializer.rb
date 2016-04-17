class CommentSerializer < ActiveModel::Serializer
  attributes :id, :author, :message, :created_at

  def author
    object.user.email
  end
end
