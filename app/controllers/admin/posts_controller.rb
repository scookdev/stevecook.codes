class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def create
    slug = generate_slug(post_params[:title])
    @post = Post.new(post_params.merge(slug: slug))

    if @post.save
      redirect_to admin_posts_path, notice: "Post successfully created!"
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    slug = generate_slug(post_params[:title])

    if @post.update(post_params.merge(slug: slug))
      redirect_to admin_posts_path, notice: "Post updated successfully!"
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :body, :status, :tags, :featured_image)
  end

  def authenticate_admin!
    raise ActionController::RoutingError.new("Not Found") unless session[:admin]
  end

  def generate_slug(title)
    slug = title.parameterize
    while Post.exists?(slug: slug)
      slug = "#{slug}-#{SecureRandom.hex(4)}"
    end
    slug
  end
end
