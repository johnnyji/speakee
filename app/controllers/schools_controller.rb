class SchoolsController < ApplicationController

  def show
    @school = School.find(params[:id])
    @confessions = @school.confessions.order("created_at DESC").page(params[:page]).per_page(3)
  end

  def create
    School.create_or_find(current_user)
    current_school = School.find(current_user_active_school_id)
    redirect_to school_path(current_school)
  end

  def switch_school
    school = School.find(params[:id])
    current_user.active_school = school.id
    current_user.save
    redirect_to school_path(current_user.active_school)
  end
end
