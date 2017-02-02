class Api::V1::CardsController < ApplicationController
  respond_to :json
  before_action :set_cache_headers!, only: [:index]

  def index
    if search_params[:search]
      cards = Card.search(search_params[:search]).order("created_at DESC")
      render json: cards,
                    adapter: :json, each_serializer: Api::V1::SearchSerializer,
                    meta: { favorite_card_ids: current_user_favorite_ids, search_term: search_params[:search] }
    else
      cards = []
      render json: cards,
                    adapter: :json, each_serializer: Api::V1::SearchSerializer,
                    meta: { favorite_card_ids: current_user_favorite_ids, search_term: "blank" }
    end
  end

  def card_names
    cards = Card.card_names
    respond_with cards
  end

  private

  def search_params
    params.permit(:search)
  end
end
