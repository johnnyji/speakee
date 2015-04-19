class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = @user.id
    if @user.school_name_array.sort == @user.education_history_array.sort #aka if the user's schools are still the same
      redirect_to(user_school_path)
    else
      redirect_to(find_or_create_school_path)
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
