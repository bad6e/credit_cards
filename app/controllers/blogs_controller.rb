class BlogsController < ApplicationController
  after_action :allow_stumble_upon_iframe
  def index
  end

  def show
    @blog = Blog.where(slug: params[:id], published: true).first
    @related_cards = Blog.friendly.find(params['id']).cards.limit(4).order("RANDOM()")
  end

  def allow_stumble_upon_iframe
    response.headers['X-Frame-Options'] = 'ALLOW-FROM http://www.stumbleupon.com/'
  end
end
