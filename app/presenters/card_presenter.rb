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

  def featured_cards_category_name
    category_list.first.parse_category_name
  end

  def rewards
    card_name.rewards.order(record_date: :desc)
  end

  def brets_favorite?
    card_name.categories.include?(Category.find_by(name: "bret's-favorite-cards"))
  end

  def category_list
    Card.find(card_id).categories
  end
end