desc 'Create the sitemap, then upload it to S3 and ping the search engines'
task best_offer: :environment do
  puts "To Infinity and Beyond!"
  class BestCards

    def initialize
      remove_old_categories_and_best_offers
      cards = select_cards_with_rewards
      set_best_offer_cards(cards)
      set_not_best_offer_cards
    end

    def set_best_offer_cards(cards_with_enough_rewards)
      card_list = cards_with_enough_rewards.map do |card|
        if (current_reward(card) >= highest_reward(card)) and (card_not_already_assigned(card.id) == false)
          card.update!(best_offer: "yes")
          Card.find(card.id).categories << best_card_category
        end
      end
    end

    def current_reward(card)
      card.rewards.order("record_date DESC").first.amount
    end

    def highest_reward(card)
      card.rewards.order("amount DESC").first.amount
    end

    def remove_old_categories_and_best_offers
      best_card_category.cards.each do |card|
        card.update!(best_offer: nil)
        card.categories.delete(best_card_category)
      end
    end

    def best_card_category
      Category.find_by(name: 'best-credit-card-offers')
    end

    def card_not_already_assigned(id)
      Card.find(id).categories.include?(best_card_category)
    end

    def select_cards_with_rewards
      card_list = Card.select("cards.*").joins(:rewards).group("cards.id").having("count(rewards.id) > ?", 6)
    end


    def set_not_best_offer_cards
      cards = Card.joins(:rewards).where(best_offer: 'no')
      cards.update_all(best_offer: 'no')

      cards = Card.joins(:rewards).where(best_offer: nil)
      cards.update_all(best_offer: 'no')

      cards = Card.where.not(:id => Reward.select(:card_id).uniq)
      cards.update_all(best_offer: 'n/a')
    end
  end
  BestCards.new
end