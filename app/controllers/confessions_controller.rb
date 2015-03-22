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
    @confession.hashtags = CreateHashtags.call(@confession)
    embed_hashtags(@confession.hashtags, @confession.body)
    if @confession.save
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

  ################################
  ########### PRIVATE ############
  ################################
  private
  
  def confession_params
    params.require(:confession).permit(:title, :body, :hashtag_list)
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
end
