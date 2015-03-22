class Confession < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :taggings
  has_many :hashtags, through: :taggings, dependent: :destroy
  
  validates :title, presence: true, uniqueness: true #write custom error message
  validates :body, presence: true

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
