class V1::CommentsController < ApplicationController
  before_action :verify_jwt_token

  def create
    blog_post = BlogPost.find(params[:blog_post_id])
    comment = blog_post.comments.new(comments_params)
    comment.user = current_user
    comment.save
    respond_with comment, location: blog_post_comments_path(blog_post)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    respond_with(comment)
  end

  private

  def comments_params
    params.require(:comment).permit(:message)
  end
end
