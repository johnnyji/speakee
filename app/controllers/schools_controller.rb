class SchoolsController < ApplicationController

  def show
    @school = School.find(params[:id])
    #WHY IS THIS NOT FINDING THE SCHOOL BY THE ID?
    @confessions = @school.confessions.order("created_at DESC").page(params[:page]).per_page(10)
  end

  def create
    School.create_or_find(current_user)
    redirect_to school_path(active_school(current_user))
  end

  # def switch
  #   @school = current_user.schools.find(params[:id])
  #   current_user.switch_school(@school)
  #   redirect_to school_path
  # end
end
