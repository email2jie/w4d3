class UsersController < ApplicationController
  before_action :disallow_being_logged_in

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def disallow_being_logged_in
    redirect_to cats_url if logged_in?
  end

end
