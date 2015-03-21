class EditComment
  extend service

  def initialize(selected_comment)
    @comment = selected_comment
  end

  def call
    if current_user.id == @comment.user_id
      @comment.update_attributes(comment_params)
    else
      redirect_to confession_path(@confession)
    end
  end
end