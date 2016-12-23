class Api::V1::CategoriesController < ApplicationController
  before_action :set_cache_headers!, only: [:show]
  respond_to :json

  def show
    cards = Category.find_by(slug: category_params[:id]).cards
    response = { cards: cards, search_term: nil, favorite_card_ids: current_user_favorite_cards }
    render json: response, include: ['rewards']
  end

  private

    def current_user_favorite_cards
      if current_user
        current_user.cards.pluck(:id)
      else
        []
      end
    end

    def category_params
      params.permit(:id)
    end
end

