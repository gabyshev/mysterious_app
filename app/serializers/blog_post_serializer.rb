class BlogPostSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :author, :url

  def author
    object.user.email
  end

  def url
    blog_post_path(object)
  end
end
