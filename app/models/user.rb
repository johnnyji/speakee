class User < ActiveRecord::Base
  has_many :confessions, dependent: :destroy
  has_many :comments
  belongs_to :school


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
        education_history: auth.extra.raw_info.education.last.school.name,
        oauth_token: auth.credentials.token,
        oauth_expiry_date: Time.at(auth.credentials.expires_at)
      )
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def name
    return "#{self.first_name} #{self.last_name}"
  end

  def picture
    @picture = GetUserFacebookPicture.call(self)
  end

  def large_picture
    self.facebook.get_picture("me", type: "large")
  end

  def location
    @user_info = self.facebook.get_object("me")
    return @user_info["location"]["name"]
  end
end
