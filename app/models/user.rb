class User < ActiveRecord::Base
  has_many :confessions
  has_many :comments

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.oauth_token = auth.credentials.token
      user.oauth_expiry_date = Time.at(auth.credentials.expires_at)
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

  def birthday
    @user_info = self.facebook.get_object("me")
    return @user_info["birthday"]
  end

  def gender
    GetUserFacebookInfo.call(self)[0] #possible to get the variable name instead of using index array
  end
end
