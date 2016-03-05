class WelcomePresenter
   attr_reader :category_id


  def best_cards
    Card.all
  end
end