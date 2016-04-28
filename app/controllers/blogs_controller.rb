class BlogsController < ApplicationController
  def index
  end

  def show
    @blog = Blog.where(slug: params[:id], published: true).first
  end
end
