class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = @user.id
    if @user.facebook_schools_list.empty?
      #redirect to some path that allows you to choose a school through a search bar
    else
      if @user.facebook_schools_list == @user.speakee_schools_list
        redirect_to school_path(active_school(@user))
      else
        redirect_to find_or_create_school
      end
    end
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
