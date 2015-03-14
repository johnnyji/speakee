class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      # user.oauth_token = auth.credentials.oauth_token
      # user.oauth_expiry_date = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
