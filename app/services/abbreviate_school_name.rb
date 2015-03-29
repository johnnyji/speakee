class AbbreviateSchoolName
  extend Service

  def initialize(school)
    @school = school
    @abbreviation_regex = /[a-z0-9-!$%^&*()_+|~=`{}\[\]:";'<>?,.\/#@]/
  end

  def call
    abbreviate = @school.gsub(@abbreviation_regex, "")
    abbreviate.gsub(/\s+/, "")
  end
end