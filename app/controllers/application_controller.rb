class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html, :js, :json

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # accesses the current_user helper method
  helper_method :current_user
end
