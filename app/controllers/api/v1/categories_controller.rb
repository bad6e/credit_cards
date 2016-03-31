class Api::V1::CategoriesController < ApplicationController
  before_action :set_cache_headers!, only: [:show]
  respond_to :json

  def show
    category_presenter = CategoryPresenter.new(params)
    respond_with category_presenter.categories_cards
  end
end

