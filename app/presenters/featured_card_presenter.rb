class FeaturedCardPresenter

  attr_reader :card_id

  def initialize(card_id)
    @card_id = card_id
  end

  def card
    Card.find(card_id)
  end

  def featured_cards_sorter(cat_name)
    Category.find_by(name: cat_name).cards.limit(4).where.not(name: card.name).order("RANDOM()")
  end

  def featured_category_name(category_name)
    Category.find_by(name: category_name).parse_category_name
  end
end