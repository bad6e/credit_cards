class CategoriesController < ApplicationController

  def index
  end

  def show
    @category = CategoryPresenter.new(params[:id])
  end
end
