class Api::V1::CardsController < ApplicationController
  respond_to :json
  before_action :set_cache_headers!, only: [:index]

  def index
    if params[:search]
      @cards = Card.search(params[:search]).order("created_at DESC").paginate(page: params[:page])
      respond_with @cards
    else
      @cards = Card.all.order('created_at DESC')
      respond_with @cards
    end
  end

  def names
    a = []
    cards  = Card.all.pluck(:id, :name)
    cards.each do |card|
      a << {id: card[0], name: card[1]}
    end
    respond_with a
  end
end
