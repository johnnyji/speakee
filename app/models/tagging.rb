class Tagging < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :confession
end
