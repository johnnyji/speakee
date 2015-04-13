class SchoolsController < ApplicationController

  def show
    @school = current_user.school
    @confessions = @school.confessions.order("created_at DESC").page(params[:page]).per_page(10)
  end

  def create
    @user = current_user
    @school = School.from_user(@user)
    @school.abbreviation = AbbreviateSchoolName.call(@school.name)
    @user.update!(school_id: @school.id)
    if @school.save
      redirect_to user_school_path
    else
      redirect_to root_path
    end
  end
end
