class ConfessionsController < ApplicationController
  def index
    @confessions = Confession.all.order("created_at DESC")
  end

  def show
  end

  def create
  end

  def update
  end

  def delete
  end

  def destroy
  end

  ########### PRIVATE ###########
  private
  def confession_params
    params.require(:confession).permit(:title, :body)
  end

end
