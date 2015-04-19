class SchoolsController < ApplicationController

  def show
    @school = current_user.current_school
    #this will automatically throw you to the last school on your school list, make a dropdown for the user to have more options to access more schools
    @confessions = @school.confessions.order("created_at DESC").page(params[:page]).per_page(10)
  end

  def create
    School.from_user(current_user)
    # current_user.current_school = current_user.schools.last
    redirect_to user_school_path
  end
end
