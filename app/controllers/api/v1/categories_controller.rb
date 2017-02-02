class Api::V1::CategoriesController < ApplicationController
  before_action :set_cache_headers!, only: [:show]
  before_action :find_category, only: [:show]
  respond_to :json

  def show
    cards = find_category.cards
    render json: cards,
                    adapter: :json, each_serializer: Api::V1::SearchSerializer,
                    meta: { favorite_card_ids: current_user_favorite_ids, search_term: nil }
  end

  private

  def category_params
    params.permit(:id)
  end

  def find_category
    @_category ||= Category.find_by(slug: category_params[:id])
  end
end
