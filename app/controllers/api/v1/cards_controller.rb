class Api::V1::CardsController < ApplicationController
  respond_to :json
  before_action :set_cache_headers!, only: [:index]

  def index
    if params[:search]
      cards = Card.search(params[:search]).order("created_at DESC")
      respond_with cards,
                   each_serializer: Api::V1::SearchSerializer,
                   search_term: params[:search]
    else
      cards = Card.all.order("created_at DESC")
      respond_with cards
    end
  end

  def card_names
    cards = Card.card_names
    respond_with cards
  end
end
