class AboutController < ApplicationController

  def index
    @linked_card = Card.find_by(name: "Chase Sapphire Preferred® Card")
    @best_cards  = Category.find_by(name: "best-credit-card-offers")
  end
end
