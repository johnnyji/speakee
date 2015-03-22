class ConfessionsController < ApplicationController
  before_action :find_confession, except: [:index, :new, :create]
  before_action :authenticate_user, except: [:index, :show]

  def index
    @confessions = Confession.all.order("created_at DESC")
  end

  def show
    @comments = @confession.comments.order("created_at DESC")
  end

  def new
    @confession = current_user.confessions.build
  end

  def create
    @confession = current_user.confessions.build(confession_params)
    if @confession.save
      @confession.hashtags = CreateHashtags.call(@confession)
      redirect_to action: "index"
    else
      render "new"
    end
  end

  def delete
  end

  def destroy
    @confession.destroy
    redirect_to action: "index"
  end

  ########### PRIVATE ###########
  private
  
  def confession_params
    params.require(:confession).permit(:title, :body, :hashtag_list)
  end

  def find_confession
    @confession = Confession.find(params[:id])
  end
end
