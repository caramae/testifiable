class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      #flash[:notice] = "Logged In!"
      redirect_to user
    else
      flash[:error] = 'Invalid username or password.'
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    #flash[:notice] = "Logged Out!"
    redirect_to login_path
  end
end
