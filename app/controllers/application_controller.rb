class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_for_login
    unless current_user
      flash[:info] = "Access reserved for memebers only. Please sign in first."
      redirect_to sign_in_path
    end
  end
end
