# app/controllers/admin/posts_controller.rb
class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(slug: params[:slug])
  end
end
