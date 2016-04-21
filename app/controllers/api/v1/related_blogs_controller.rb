class Api::V1::RelatedBlogsController < ApplicationController
  respond_to :json

  def show
    @related_blogs = Card.find(params[:id]).blogs.order('created_at DESC')
    respond_with @related_blogs
  end
end
