class Api::V1::CategoriesController < ApplicationController
  respond_to :json

  def show
    category_presenter = CategoryPresenter.new(params)
    respond_with category_presenter.categories_cards
  end
end

