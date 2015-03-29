class SchoolsController < ApplicationController
  def create
    @user = current_user || User.find(params[:id])
    @school = School.from_user(@user)
    @school.abbreviation = AbbreviateSchoolName.call(@school.name)
    @user.update!(school_id: @school.id)
    if @school.save
      redirect_to root_path
    else
      render "new"
    end
  end
end
