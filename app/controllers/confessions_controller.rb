class ConfessionsController < ApplicationController
  before_filter :require_user, only: [:index]
  before_action :find_confession, except: [:index, :new, :create]
  before_action :authenticate_user, except: [:index, :show]

  def index
    # shows every confession that belongs to the school the user belongs to
    @confessions = Confession.all.order("created_at DESC")
  end

  def show
    @comments = @confession.comments.order("created_at DESC")
  end

  def new
    @school = School.find(params[:school_id])
    @confession = current_user.confessions.build
  end

  def create
    @confession = current_user.confessions.build(confession_params)
    @confession.hashtags = CreateHashtags.call(@confession)
    embed_hashtags(@confession.hashtags, @confession.body)
    if @confession.save
      redirect_to school_path(@confession.school)
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

  ################################
  ########### PRIVATE ############
  ################################
  private
  
  def confession_params
    params.require(:confession).permit(:title, :body, :hashtag_list, :school_id)
  end

  def find_confession
    @confession = Confession.find(params[:id])
  end

  def embed_hashtags(hashtags, body)
    hashtags.each do |hashtag|
      matched_tag = body.scan("##{hashtag.tag}").flatten.uniq.join("")
      body.gsub!(matched_tag, view_context.link_to("##{hashtag.tag}", hashtag_path(hashtag)))
    end
  end

  def require_user
    redirect_to new_session_path unless current_user
  end
end
