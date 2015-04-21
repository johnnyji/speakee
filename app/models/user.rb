class User < ActiveRecord::Base
  has_many :confessions, dependent: :destroy
  has_many :comments
  has_many :school_users
  has_many :schools, through: :school_users
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.update_attributes(
        provider: auth.provider,
        uid: auth.uid,
        first_name: auth.info.first_name,
        last_name: auth.info.last_name,
        gender: auth.extra.raw_info.gender,
        email: auth.extra.raw_info.email,
        birthday: auth.extra.raw_info.birthday,
        timezone: auth.extra.raw_info.timezone,
        education_history: parse_school_names(auth.extra.raw_info.education),
        current_school: auth.extra.raw_info.education.last.school.name,
        oauth_token: auth.credentials.token,
        oauth_expiry_date: Time.at(auth.credentials.expires_at)
      )
    end
  end

  def education_history_array
    eval(self.education_history).uniq
  end

  def school_name_array
    self.schools.map { |school| school.name }
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def picture
    self.facebook.get_picture('me')
  end

  def large_picture
    self.facebook.get_picture("me", type: "large")
  end

  def location
    @user_info = self.facebook.get_object("me")
    @user_info["location"]["name"]
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  private

  def self.parse_school_names(education_history)
    education_history.map do |hash|
      flatten_hash(hash)
    end.map { |school| school[:"school.name"] }
  end

  def self.flatten_hash(hash)
    hash.each_with_object({}) do |(k, v), h|
      if v.is_a? Hash
        flatten_hash(v).map do |h_k, h_v|
          h["#{k}.#{h_k}".to_sym] = h_v
        end
      else 
        h[k] = v
      end
    end
  end


end
