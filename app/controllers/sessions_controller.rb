class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    # user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:user_name] = "#{user.first_name.capitalize} #{user.last_name.capitalize}"
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
