class UsersController < ApplicationController
  before_filter :check_for_login, only: [:edit, :update]
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    @user.locked = false if @user.email_changed?
    if @user.save(validate: false)
      flash[:success] = "Successful Update Your Account Info"
      redirect_to home_path
    else
      render :edit
    end
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end
end
