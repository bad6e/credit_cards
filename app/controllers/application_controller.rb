class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def no_index_no_follow
    @meta_robots_instructions = "noindex, nofollow"
  end
end
