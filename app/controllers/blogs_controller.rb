class BlogsController < ApplicationController
  def index
  end

  def show
    @blog = Blog.where(slug: params[:id], published: true).first
    @related_cards = Blog.friendly.find(params['id']).cards.limit(4).order("RANDOM()")
  end
end
