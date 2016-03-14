class WelcomePresenter
   attr_reader :category_id

  def best_cards
    Category.find_by(name: "best-credit-card-offers").cards
  end

  def best_airline_cards
    Category.find_by(name: "airline-credit-cards").cards.where(best_offer: "yes")
  end

  def best_hotel_cards
    Category.find_by(name: "hotel-credit-cards").cards.where(best_offer: "yes")
  end

  def featured_card
    Card.find(40)
  end
end