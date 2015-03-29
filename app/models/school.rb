class School < ActiveRecord::Base
  has_many :users
  has_many :confessions
  abbreviation_regex = /[a-z0-9-!$%^&*()_+|~=`{}\[\]:";'<>?,.\/#@]/

  def self.from_user(user)
    self.where(name: user.education_history).first_or_initialize.tap do |school|
      school.name = user.education_history
      school.abbreviation = abbreviate_name(user.education_history)
      school.save!
    end
  end

  def abbreviate_name(name)
    abbreviate = name.gsub!(abbreviation_regex, "")
    abbreviate.gsub!(/\s+/, "")
  end
end
