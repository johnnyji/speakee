class Hashtag < ActiveRecord::Base
  has_many :taggings
  has_many :confessions, through: :taggings
end
