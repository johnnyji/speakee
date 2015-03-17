class Confession < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  validates :title, presence: true, uniqueness: true #write custom error message
  validates :body, presence: true
end
