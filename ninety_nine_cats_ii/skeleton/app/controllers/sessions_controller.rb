class SessionsController < ApplicationController
  before_action :disallow_being_logged_in, except: [:destroy]

  def new
    @user = User.new
    @login = true
    render :login_form
  end

  def create
    @user = User.find_by_credentials(user_params)

    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      @user = User.new(user_params)
      flash[:errors] = ["Password/Username is Incorrect!"]
      @login = true
      render :login_form
    end

  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

  def disallow_being_logged_in
    redirect_to cats_url if logged_in?
  end

end
