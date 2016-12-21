class Api::V1::CardsController < ApplicationController
  respond_to :json
  before_action :set_cache_headers!, only: [:index]

  def index
    if params[:search]
      cards = Card.search(params[:search]).order("created_at DESC")
      response = { cards: cards, search_term: params[:search] }
      render json: response, include: ['rewards']
    else
      cards = Card.all.order('created_at DESC')
      respond_with cards
    end
  end

  def names
    card_names = []
    cards = Card.card_names
    cards.each do |card|
      card_names << {id: card[0], name: card[1]}
    end
    respond_with card_names
  end
end
