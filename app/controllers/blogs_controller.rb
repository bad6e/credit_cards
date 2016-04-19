class BlogsController < ApplicationController
  def index
  end

  def show
    @blog = Blog.find_by(slug: params[:id])
  end
end
