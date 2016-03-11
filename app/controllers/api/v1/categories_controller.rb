class Api::V1::CategoriesController < ApplicationController
  respond_to :json

  def show
    respond_with Category.find(params[:id]).cards
  end
end