class SessionsController < ApplicationController
  def new
    reset_session
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user
    else
      redirect_to :back, notice: "Invalid username or password."
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
