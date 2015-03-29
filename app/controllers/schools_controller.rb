class SchoolsController < ApplicationController

  def show
    @school = current_user.school
    @confessions = @school.confessions.all.order("created_at DESC")
  end

  def create
    @user = current_user || User.find(params[:id])
    @school = School.from_user(@user)
    @school.abbreviation = AbbreviateSchoolName.call(@school.name)
    @user.update!(school_id: @school.id)
    if @school.save
      redirect_to user_school_path
    else
      render "new"
    end
  end
end
