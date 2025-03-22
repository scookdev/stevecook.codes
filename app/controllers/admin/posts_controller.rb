class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!  # Optional: Add authentication check

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "Post updated successfully!"
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def authenticate_admin!
    # You could check for a session or current_user to verify admin status.
  end
end
