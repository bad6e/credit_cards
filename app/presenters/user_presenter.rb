class UserPresenter
  attr_reader :category_id

  def airline_category
    Category.find_by(name: "airline-credit-cards")
  end

  def airline_card_number
    airline_category.cards.count
  end

  def hotel_category
    Category.find_by(name: "hotel-credit-cards")
  end

  def hotel_card_number
    hotel_category.cards.count
  end

  def business_category
    Category.find_by(name: "business-rewards-credit-cards")
  end

  def business_card_number
    business_category.cards.count
  end

  def travel_category
    Category.find_by(name: "travel-credit-cards")
  end

  def travel_card_number
    travel_category.cards.count
  end
end

