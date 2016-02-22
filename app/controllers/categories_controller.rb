class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = CategoryPresenter.new(params[:id])
  end
end
