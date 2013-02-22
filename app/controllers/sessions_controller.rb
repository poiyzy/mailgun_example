class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.locked
        flash[:error] = "Your Email Address is invalid, please update it."
        redirect_to edit_user_path(current_user)
      else
        redirect_to home_path
      end
    else
      flash[:error] = "Incorrect email or password. Please try again."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
