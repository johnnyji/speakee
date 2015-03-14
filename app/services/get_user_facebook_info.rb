class GetUserFacebookInfo
  extend Service

  def initialize(user)
    @user = user
  end

  def call
    user_personal_information
  end

  private
  def user_personal_information
    user_info = @user.facebook.get_object("me")
    gender = user_info["gender"]
    email = user_info["email"]
    [ gender, email ]
  end
end