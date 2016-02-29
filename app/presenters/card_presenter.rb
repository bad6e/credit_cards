class CardPresenter

  attr_reader :card_id

  def initialize(card_id)
    @card_id = card_id
  end

  def card_name
    Card.find(card_id)
  end

  def parsed_category_names
    Card.find(card_id).parse_card_categories_names
  end

  def featured_cards
    category_list.first.cards.limit(4).where.not(name: card_name.name).order("RANDOM()")
  end

  def bonus_cards
    Category.find_by(name: "best-credit-card-offers").cards.limit(2).where.not(name: card_name.name).order("RANDOM()")
  end

  def featured_cards_category_name
    category_list.first.parse_category_name
  end

  def rewards
    card_name.rewards.order(record_date: :desc)
  end

  def card_has_bonus?
    return true if card_name.rewards != []
  end

  def category_list
    Card.find(card_id).categories
  end
end