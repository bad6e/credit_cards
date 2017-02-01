class Api::V1::CategoriesController < ApplicationController
  before_action :set_cache_headers!, only: [:show]
  before_action :find_category, only: [:show]
  respond_to :json

  def show
    cards = find_category.cards
    respond_with cards,
                 each_serializer: Api::V1::CategoryCardSerializer,
                 search_term: nil
  end

  private

  def current_user_favorite_cards
    current_user ? current_user.cards.pluck(:id) : []
  end

  def category_params
    params.permit(:id)
  end

  def find_category
    @_category ||= Category.find_by(slug: category_params[:id])
  end
end
