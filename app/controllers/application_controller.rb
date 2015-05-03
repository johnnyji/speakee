class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html, :js, :json

  private

  def current_user_active_school_id
    @current_user_active_school_id = !current_user.active_school.nil? ? current_user.active_school : current_user.schools.last.id
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
    if logged_in? && current_user.schools.last
      redirect_to school_path(current_user.schools.last) if request.fullpath == root_path
    end
  end

  helper_method :current_user, :logged_in?, :current_user_active_school_id
end
