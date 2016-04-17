class V1::BlogPostsController < ApplicationController
  before_filter :verify_jwt_token, except: [:index, :show]
  before_action :set_post,         only:   [:show, :update, :destroy]

  def index
    blog_posts = BlogPost.all
    respond_with(blog_posts)
  end

  def create
    blog_post = BlogPost.new(blog_post_params)
    blog_post.save
    respond_with(blog_post)
  end

  def show
    respond_with(@blog_post)
  end

  def update
    @blog_post.update(blog_post_params)
    respond_with(@blog_post)
  end

  def destroy
    @blog_post.destroy
    respond_with(@blog_post)
  end

  private

  def set_post
    @blog_post = BlogPost.find(params[:id])
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :body, :user_id)
  end
end
