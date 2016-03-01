class CardPresenter

  attr_reader :card_id

  def initialize(card_id)
    @card_id = card_id
  end

  def card
    Card.find(card_id)
  end

  def featured_cards
    category_list.first.cards.limit(4).where.not(name: card.name).order("RANDOM()")
  end

  def bonus_cards
    Category.find_by(name: "best-credit-card-offers").cards.limit(2).where.not(name: card.name).order("RANDOM()")
  end

  def featured_cards_category_name
    category_list.first.parse_category_name
  end

  def rewards
    card.rewards.order(record_date: :desc)
  end

  def card_has_bonus?
    return true if card.rewards != []
  end

  def category_list
    Card.find(card_id).categories
  end
end