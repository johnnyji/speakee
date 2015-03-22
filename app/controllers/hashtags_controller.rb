class HashtagsController < ApplicationController

  def show
    @hashtag = Hashtag.find(params[:id])
    @confessions = @hashtag.confessions.order("created_at DESC")
  end

end
