class SchoolsController < ApplicationController

  def show
    @school = School.find(params[:id])
    @confessions = @school.confessions.order("created_at DESC").page(params[:page]).per_page(7)
  end

  def create
    School.create_or_find(current_user)
    redirect_to school_path(current_user_active_school)
  end

  def switch_school
    school = School.find(params[:id])
    if current_user_active_school.id == school.id
      redirect_to school_path(current_user_active_school)
    else
      current_user.active_school = school.id
      current_user.save
      redirect_to school_path(current_user_active_school)
    end
  end
end
