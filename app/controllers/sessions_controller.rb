class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    session[:user_name] = "#{user.first_name.capitalize} #{user.last_name.capitalize}"
    redirect_to root_path
  end

  def show #profile page
    user = User.find(params[:id])
    # GetUserFacebookInfo.call(@user)
    current_user = user.facebook.get_object("me")
    @user_gender = current_user["gender"]
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
