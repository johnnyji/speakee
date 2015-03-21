class ExtractHashtags
  extend Service

  def initialize(confession)
    @confession = confession
  end

  def call
    tags = @confession.hashtag_list
    tags.clear if tags.length > 0
    new_tags = @confession.extract_hashtags
    new_tags.each { |tag| @confession.hashtags.create tag: tag }
  end
end