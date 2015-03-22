class CreateHashtags
  extend Service

  def initialize(confession)
    @confession = confession
  end

  def call
    hashtags = @confession.extract_hashtags
    new_or_found_tags = hashtags.collect { |tag| Hashtag.find_or_create_by(tag: tag) }
    return new_or_found_tags
  end
end