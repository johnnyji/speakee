class SchoolsController < ApplicationController
  def create
    @user = current_user || User.find(params[:id])
    @school = School.from_user(@user)
    @school.abbreviation = AbbreviateSchoolName.call(@user.education_history)
    current_user.school_id = @school.id
    current_user.save!
    if @school.save && current_user.save
      redirect_to root_path
    else
      render "new"
    end
  end
end
