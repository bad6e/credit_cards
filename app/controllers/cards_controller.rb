class CardsController < ApplicationController
  def show
    @card = Card.find(params[:id])
    @related_card = Card.find(params[:id]).parse_name
    category = Card.find(params[:id]).categories
    @featured_cards = category.first.cards.limit(4).order("RANDOM()")
  end
end
