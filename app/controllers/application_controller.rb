class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?  #by declaring it as hepler methods, we can access it on our views also

  # Accessing the current user details we can access the current user details using session[:]
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  # Whether a user is logged in or not
  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert]="You must be logged in to perform the action!!"
      redirect_to login_path
    end
  end

end
