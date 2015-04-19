class School < ActiveRecord::Base
  has_many :confessions
  has_many :school_users
  has_many :users, through: :school_users

  def self.from_user(user)
    user.education_history_array.each do |schoolname|
      where(name: schoolname).first_or_initialize.tap do |school|
        school.name = schoolname
        school.save!
        user.schools << school
      end
    end
  end
end
