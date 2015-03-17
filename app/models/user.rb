class User < ActiveRecord::Base
  has_many :confessions
  has_many :comments

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.birthday = auth.info.birthday
      user.oauth_token = auth.credentials.token
      user.oauth_expiry_date = Time.at(auth.credentials.expires_at)
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def picture
    @picture = GetUserFacebookPicture.call(self)
  end
end
