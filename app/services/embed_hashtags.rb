class EmbedHashtags
  extend Service

  def initialize(confession_hashtags, confession_body)
   @hashtags = confession_hashtags
   @confession_body = confession_body
  end

  def call
    @hashtags.each do |hashtag|
      matched_hashtag = @confession_body.scan("##{hashtag.tag}").flatten.uniq.join("") #makes sure match is unique if theres duplicate tags
      @confession_body.gsub!(matched_hashtag, "<a href='./hashtags/#{hashtag.id}'>##{hashtag.tag}</a>")
    end
  end
end