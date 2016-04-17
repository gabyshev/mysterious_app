class Comment < ActiveRecord::Base
  belongs_to :blog_post
  belongs_to :user

  validates_presence_of :message
end
