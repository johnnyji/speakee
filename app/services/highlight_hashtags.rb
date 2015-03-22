class HighlightHashtags
  extend Service

  def initialize(hashtag_list, confession_body)
   @hashtag_list = hashtag_list
   @confession_body = confession_body
  end

  def call
    @hashtag_list.each do |hashtag|
      matched_tag = @confession_body.scan("##{hashtag}").flatten.uniq.join("") #makes sure match is unique if theres duplicate tags
      @confession_body.gsub!(matched_tag, ("<a href='www.google.ca'>##{hashtag}</a>").html_safe)
    end
  end
end