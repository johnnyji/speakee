class ExtractHashtags
  extend Service

  def initialize(confession)
    @confession = confession
  end

  def call
    new_tags = @confession.extract_hashtags
    new_tags.each { |tag| @confession.hashtags.create tag: tag }
  end
end