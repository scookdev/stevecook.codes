# app/controllers/admin/posts_controller.rb
class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!  # Optional: Add authentication check

  # Show the form to edit an existing post
  def edit
    @post = Post.find(params[:id])
  end

  # Handle the form submission to update the post
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "Post updated successfully!"
    else
      render :edit
    end
  end

  private

  # Strong parameters for the post
  def post_params
    params.require(:post).permit(:title, :content)
  end

  # Optional: Add authentication logic (e.g., verify admin logged in)
  def authenticate_admin!
    # You could check for a session or current_user to verify admin status.
  end
end
