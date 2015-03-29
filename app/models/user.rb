class User < ActiveRecord::Base
  has_many :confessions, dependent: :destroy
  has_many :comments
  belongs_to :school


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.gender = auth.extra.raw_info.gender
      user.email = auth.extra.raw_info.email
      user.birthday = auth.extra.raw_info.birthday
      user.timezone = auth.extra.raw_info.timezone
      user.education_history = auth.extra.raw_info.education.last.school.name
      user.oauth_token = auth.credentials.token
      user.oauth_expiry_date = Time.at(auth.credentials.expires_at)
      user.save!
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
