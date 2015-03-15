class GetUserFacebookPicture
  extend Service

  def initialize(user)
    @user = user
  end

  def call
    user_picture = @user.facebook.get_picture("me")
    return user_picture
  end
end