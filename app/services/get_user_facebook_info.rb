class GetUserFacebookInfo
  extend Service

  def initialize(current_user)
    @current_user = current_user
  end

  def call
    user_info = @current_user.facebook.get_object("me")
    binding.pry
    @user_gender = user_info["gender"]
  end
end