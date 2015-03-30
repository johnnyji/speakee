class School < ActiveRecord::Base
  has_many :users
  has_many :confessions

  def self.from_user(user)
    where(name: user.education_history).first_or_initialize.tap do |school|
      school.name = user.education_history
      school.save!
    end
  end
end
