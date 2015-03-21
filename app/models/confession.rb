class Confession < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  has_many :taggings
  has_many :hashtags, through: :taggings
  
  validates :title, presence: true, uniqueness: true #write custom error message
  validates :body, presence: true

  def tag_list_string
    self.hashtags.collect do |hashtag|
      hashtag.tag
    end.join(", ")
  end

  def tag_list_array
    self.tag_list_string.split(", ")
  end

  def tagged_with?(hashtag)
    return self.tag_list_array.include?(hashtag)
  end
end
