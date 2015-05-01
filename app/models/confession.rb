class Confession < ActiveRecord::Base
  belongs_to :user
  belongs_to :school
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :hashtags, through: :taggings, dependent: :destroy
  
  validates_presence_of :body, message: "Your confession can't be blank!"
  validates_presence_of :title, message: "Enter a title!"
  validates_uniqueness_of :title, { scope: :school_id, message: "This title's already taken!" }

  before_save :extract_hashtags

  def hashtag_list_string
    self.hashtags.collect do |hashtag|
      hashtag.tag
    end.join(", ")
  end

  def hashtag_list
    self.hashtag_list_string.split(", ")
  end

  def tagged_with?(hashtag)
    return self.hashtag_list_string.include?(hashtag)
  end

  def extract_hashtags
    hashtag_regex = /(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i
    hashtag_array = self.body.scan(hashtag_regex).flatten.uniq
  end
end
