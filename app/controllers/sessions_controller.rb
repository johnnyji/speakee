class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    @user_picture = GetUserFacebookPicture.call(@user)
    session[:user_id] = @user.id
    session[:user_name] = "#{@user.first_name.capitalize} #{@user.last_name.capitalize}"
    redirect_to root_path
  end

  def show #profile page
    @user = User.find(params[:id])
    @gender, @email = GetUserFacebookInfo.call(@user)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
