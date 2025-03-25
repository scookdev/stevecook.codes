class SessionsController < ApplicationController
  def new
    redirect_to admin_posts_path if session[:admin]
  end

  def create
    password = params[:password]

    # Check if the password matches the stored hash
    if BCrypt::Password.new(Rails.application.credentials.password_hash) == password
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
