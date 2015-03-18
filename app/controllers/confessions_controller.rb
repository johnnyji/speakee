class ConfessionsController < ApplicationController
  before_action :find_confession, except: [:index, :new, :create]
  # before_action :authenticate!, except: [:index, :show]
  # write own user authentication

  def index
    @confessions = Confession.all.order("created_at DESC")
  end

  def show
    @comments = @confession.comments.order("created_at DESC")
  end

  def new
    if current_user
      @confession = current_user.confessions.build
    else
      redirect_to new_session_path #temporary fix for when no user is logged in
    end
  end

  def create
    if current_user
      @confession = current_user.confessions.build(confession_params)
      if @confession.save
        redirect_to action: "index"
      else
        render "new"
      end
    else
      redirect_to action: "index"
    end
  end

  def edit
  end

  def update
    @confession.attributes = confession_params
    if @confession.save(confession_params)
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
    params.require(:confession).permit(:title, :body)
  end

  def find_confession
    @confession = Confession.find(params[:id])
  end
end
