class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper

  def no_index_no_follow
    @meta_robots_instructions = "noindex, nofollow"
  end
end
