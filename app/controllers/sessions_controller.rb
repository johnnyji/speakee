class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def show #profile page
    @user = User.find(params[:id])
    @confessions = @user.confessions.order("created_at DESC")
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
