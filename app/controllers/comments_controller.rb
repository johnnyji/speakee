class CommentsController < ApplicationController
  before_action :find_confession

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
    @comment = @confession.comments.find(params[:id])
  end

  def update
    @comment = @confession.comments.find(params[:id])
    EditComment.call(@comment)
  end

  def delete
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_confession
    @confession = Confession.find(params[:confession_id])
  end
end
