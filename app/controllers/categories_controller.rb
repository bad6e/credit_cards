class CategoriesController < ApplicationController

  def show
    @category = CategoryPresenter.new(params[:id])
  end
end
