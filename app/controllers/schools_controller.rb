class SchoolsController < ApplicationController

  def show
    raise params.to_yaml #this shows the content being passed is "3", and finding the current_user.schools.find(3) in the console finds the school, so why doesn't this method do it?
    @school = current_user.schools.find(params[:id])
    #WHY IS THIS NOT FINDING THE SCHOOL BY THE ID?
    @confessions = @school.confessions.order("created_at DESC").page(params[:page]).per_page(10)
  end

  def create
    School.from_user(current_user)
    redirect_to user_school_path(current_user.selected_school.id)
    binding.pry
  end

  def switch
    @school = current_user.schools.find(params[:id])
    current_user.switch_school(@school)
    redirect_to user_school_path
  end
end
