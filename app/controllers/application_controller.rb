class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html, :js, :json

  private

  def no_schools_found(user)
    user.facebook_schools_list.empty? && user.speakee_schools_list.empty?
  end

  def current_user_active_school
    @current_user_active_school = !current_user.active_school.nil? ? School.find(current_user.active_school) : current_user.schools.last.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def logged_in?
    current_user != nil
  end

  def authenticate_user
    unless logged_in?
      redirect_to new_session_path
    end
  end

  # redirects the logged in user to their school if they have a school
  before_action do
    if logged_in? && current_user.schools.exists?
      redirect_to school_path(current_user_active_school) if request.fullpath == root_path
    end
  end

  helper_method :current_user, :logged_in?, :current_user_active_school
end
