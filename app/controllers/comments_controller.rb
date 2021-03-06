class CommentsController < ApplicationController
  before_action :find_confession
  before_action :find_comment, only: [:edit, :update, :delete, :destroy]

  def show
  end

  def new
    @comment = @confession.comments.new(comment_params)
  end

  def create
    @comment = @confession.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.confession_id = @confession.id
    if @comment.save
      redirect_to confession_path(@confession)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(comment_params)
      head :no_content
    else
      head :no_content
    end
  end

  def delete
    binding.pry
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_confession
    @confession = Confession.find(params[:confession_id])
  end

  def find_comment
    @comment = @confession.comments.find(params[:id])
  end
end
