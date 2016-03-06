class WelcomePresenter
   attr_reader :category_id

  def best_cards
    Category.find_by(name: "best-credit-card-offers").cards
  end
end