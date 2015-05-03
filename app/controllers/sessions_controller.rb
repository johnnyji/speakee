class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if user.facebook_schools_list.empty? && user.speakee_schools_list.empty?
      #redirect to some path that allows you to choose a school through a search bar
      redirect_to select_school
    else
      if user.facebook_schools_list == user.speakee_schools_list
        redirect_to school_path(current_user_active_school_id)
      else
        redirect_to find_or_create_school
      end
    end
  end

  def show #profile page
    @user = User.find(params[:id])
    @active_school = School.find(current_user_active_school_id)
    @non_active_schools = @user.schools.where.not(id: current_user_active_school_id)
    @confessions = @user.confessions.order("created_at DESC")
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def select_school
    # this page will have a query bar for the user to select a school
  end

end
