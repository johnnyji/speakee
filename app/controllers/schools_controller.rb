class SchoolsController < ApplicationController
  def create
    @user = current_user || User.find(params[:id])
    @school = School.from_user(@user)
  end
end
