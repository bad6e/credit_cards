class WelcomePresenter
   attr_reader :category_id

  def best_cards
    Card.cards_with_multiple_categories(["travel-credit-cards", "best-credit-card-offers"])
  end

  def our_favorite_cards
    Category.find_by(name: "our-favorite-credit-cards").cards
  end

  def featured_card
    Card.find_by(name: "Starwood Preferred Guest® Credit Card from American Express")
  end
end