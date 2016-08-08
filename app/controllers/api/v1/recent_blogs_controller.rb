class Api::V1::RecentBlogsController < ApplicationController
   respond_to :json

  def index
    recent_blogs = Blog.order(created_at: :desc).where(published: true).limit(6)
    respond_with recent_blogs
  end
end
