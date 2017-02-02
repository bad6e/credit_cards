class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_action :allow_stumble_upon_iframe

  include SessionsHelper
  include ApplicationHelper

  def current_user_favorite_ids
    if current_user
      current_user.cards.pluck(:id)
    end
  end

  def set_cache_headers!
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def no_index_no_follow
    @meta_robots_instructions = "noindex, nofollow"
  end

  def allow_stumble_upon_iframe
    response.headers['X-Frame-Options'] = 'ALLOW-FROM http://www.stumbleupon.com/'
  end

  def current_user_favorite_cards
    if current_user
      current_user.cards.pluck(:id)
    else
      []
    end
  end
end
