class FeaturedCardPresenter

  attr_reader :card_id

  def initialize(card_id)
    @card_id = card_id
  end

  def card
    Card.find(card_id)
  end

  def airline_category
    Category.find_by(name: "airline-credit-cards")
  end

  def business_category
    Category.find_by(name: "business-rewards-credit-cards")
  end

  def best_card_category
    Category.find_by(name: "best-credit-card-offers")
  end

  def category_list
    card.categories
  end

  def card_category_include_three?(card, category_one, category_two, category_three)
    card.categories.include?(category_one) && card.categories.include?(category_two) && card.categories.include?(category_three)
  end

  def card_category_include_two?(card, category_one, category_two)
    card.categories.include?(category_one) && card.categories.include?(category_two)
  end

  def card_category_only_include?(card, category_one)
    card.categories.include?(category_one) && (card.categories.count == 1)
  end

  def featured_cards_sorter(cat_name)


    #All Airline Business Carss
    if (card_category_include_three?(card, airline_category, business_category, best_card_category) || card_category_include_two?(card, airline_category, business_category))

      Card.find_cards_that_are_in_multiple_categories(["airline-credit-cards", "business-rewards-credit-cards", "best-credit-card-offers"]).limit(4).where.not(name: card.name).order("RANDOM()")
    #All Plain Business Card

        elsif (card_category_include_two?(card, business_category, best_card_category) || card_category_only_include?(card, business_category))

      Card.find_cards_that_are_in_multiple_categories(["business-rewards-credit-cards"]).limit(4).where.not(name: card.name).order("RANDOM()")

    else
      Category.find_by(name: cat_name).cards.limit(4).where.not(name: card.name).order("RANDOM()")
    end
  end


  def featured_category_name(cat_name)
    if (card_category_include_three?(card, airline_category, business_category, best_card_category) || card_category_include_two?(card, airline_category, business_category))
      "Airline Business Credit Cards"
    elsif (card_category_include_two?(card, business_category, best_card_category) || card_category_only_include?(card, business_category))
      "Business Credit Cards"
    else
      Category.find_by(name: cat_name).parse_category_name
    end
  end
end