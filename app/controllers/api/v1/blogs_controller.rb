class Api::V1::BlogsController < ApplicationController
  respond_to :json

  def index
    @blogs = Blog.all.order('created_at DESC').where(published: true)
    respond_with @blogs
  end
end

