class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  include ApplicationHelper

  def set_cache_headers!
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def no_index_no_follow
    @meta_robots_instructions = "noindex, nofollow"
  end

  def blog
    redirect_to "http://www.toomanymiles.com/blog#{request.fullpath.gsub('/blog','')}", :status => :moved_permanently
  end
end
