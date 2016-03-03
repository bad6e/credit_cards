class CardPresenter

  attr_reader :card_id

  def initialize(card_id)
    @card_id = card_id
  end

  def card
    Card.find(card_id)
  end


  #Related Cards Display Logic
  def featured_cards_category_name
    category_list.first.parse_category_name
  end

  def featured_cards
    category_list.first.cards.limit(4).where.not(name: card.name).order("RANDOM()")
  end

  #Cards With Bonuses Dispplay Logic
  def parse_category_name(unparsed_category_name)
    unparsed_category_name.gsub("-", " ").titleize
  end

  def bonus_cards(category_name)

  # Find A Categories cards where the card's reward is not zero - and then display all only two of these cards - picking them randomly
    a = Category.find_by(name: category_name).cards.map do |card|
      card.rewards
    end

    cards_ids = a.flatten.map do |r|
      r.card_id
    end

    cards_ids = cards_ids.uniq
    rewards = cards_ids.map do |id|
      Reward.find_by(card_id: id)
    end
    cards = rewards.map do |id|
      Card.find(id.card_id)
    end
    cards.uniq[0..1]
  end

  #Logic for displaying the most recent rewards
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