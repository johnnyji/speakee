class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if no_schools_found(user)
      redirect_to select_school
    else
      if user.facebook_schools_list == user.speakee_schools_list
        redirect_to school_path(current_user_active_school)
      else
        redirect_to find_or_create_school
      end
    end
  end

  def show #profile page
    @user = User.find(params[:id])
    @non_active_schools = @user.schools.where.not(id: current_user_active_school.id)
    @confessions = @user.confessions.order("created_at DESC").page(params[:page]).per_page(7)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def select_school
    school = School.find_school_by_name(params[:query])
    current_user.schools << school
    redirect_to school_path(current_user_active_school)
  end

end
