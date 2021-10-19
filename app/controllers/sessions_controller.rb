class SessionsController < ApplicationController

  before_action :logged_in_redirect, only: [:new, :create]
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # if user checks whether the email address exists or not and user.authenticate check the password
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id   #used to keep the user logged in
      flash[:notice] = "Logged in successfully"
      redirect_to user_path(user) 
    else
      flash.now[:alert]= "Login credentials invalid"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
    
  end

  private
  def logged_in_redirect
    if logged_in?
      flash[:alert]="You are already logged in!!"
      redirect_to user_path(current_user)
    end
  end

end
