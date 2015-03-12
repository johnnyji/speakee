class ConfessionsController < ApplicationController
  before_action :find_confession, except: [:index, :new, :create]

  def index
    @confessions = Confession.all.order("created_at DESC")
  end

  def show
  end

  def new
    @confession = Confession.new
  end

  def create
    @confession = Confession.create(confession_params)
    if @confession.save
      redirect_to action: "index"
    else
      render "new"
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
