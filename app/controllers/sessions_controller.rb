class SessionsController < ApplicationController
  def new
  end

  def create
    password = params[:password]
    if Bcrypt::Password.new(ENV["PASSWORD_HASH"]) == password
      session[:admin] = true
      redirect_to admin_posts_path, notice: "Successfully logged in"
    else
      flash.now[:alert] = "Incorrect password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:admin)
    redirect_to root_path, notice: "Logged out"
  end
end
