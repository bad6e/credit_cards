class CardPresenter

  attr_reader :card_id

  def initialize(card_id)
    @card_id = card_id
  end

  def card_name
    Card.find(card_id)
  end

  def category_name
    Card.find(card_id).parse_name
  end

  def featured_cards
    categories.first.cards.limit(4).where.not(name: card_name.name).order("RANDOM()")
  end

  private

  def categories
    Card.find(card_id).categories
  end
end