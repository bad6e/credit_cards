desc 'Create the sitemap, then upload it to S3 and ping the search engines'
task set_best_offer: :environment do
  class BestCards

    def initialize
      remove_old_categories_and_best_offers
      set_best_offer_cards(select_cards_with_more_than_six_rewards)
      set_not_best_offer_cards
    end

    def set_best_offer_cards(cards_with_enough_rewards)
      card_list = cards_with_enough_rewards.map do |card|
        if (current_reward(card) >= highest_reward(card)) and (card_not_already_assigned(card.id) == false)
          update_best_offer_to_yes(card)
          assign_category_to_best_card_category(card)
        elsif percentage_change(card) <= 20
          update_best_offer_to_ok(card)
        end
      end
    end

    def percentage_change(card)
      c_reward = current_reward(card).to_f
      h_reward = highest_reward(card).to_f
      (((c_reward - h_reward) / (h_reward)) * 100).abs
    end

    def update_best_offer_to_yes(card)
      card.update(best_offer: "yes")
    end

    def update_best_offer_to_ok(card)
      card.update(best_offer: "ok")
    end

    def assign_category_to_best_card_category(card)
      Card.find(card.id).categories << best_card_category
    end

    def current_reward(card)
      card.rewards.order("record_date DESC").first.amount
    end

    def highest_reward(card)
      card.rewards.order("amount DESC").first.amount
    end

    def remove_old_categories_and_best_offers
      Card.update_all(best_offer: nil)
      best_card_category.cards.each do |card|
        card.categories.delete(best_card_category)
      end
    end

    def best_card_category
      Category.find_by(name: 'best-credit-card-offers')
    end

    def card_not_already_assigned(id)
      Card.find(id).categories.include?(best_card_category)
    end

    def select_cards_with_more_than_six_rewards
      Card.select("cards.*").joins(:rewards).group("cards.id").having("count(rewards.id) > ?", 6)
    end

    def select_cards_with_less_than_or_eqaul_to_six_rewards
      Card.select("cards.*").joins(:rewards).group("cards.id").having("count(rewards.id) <= ?", 6)
    end

    def set_not_best_offer_cards
      update_cards_with_less_than_six_rewards_to_na
      update_cards_with_more_than_six_rewards_to_no
      update_cards_with_no_rewards_to_na
    end

    def update_cards_with_less_than_six_rewards_to_na
      cards_with_less_rewards = select_cards_with_less_than_or_eqaul_to_six_rewards
      cards_with_less_rewards.joins(:rewards).where(best_offer: nil).update_all(best_offer: 'n/a')
    end

    def update_cards_with_more_than_six_rewards_to_no
      Card.joins(:rewards).where(best_offer: nil).update_all(best_offer: 'no')
    end

    def update_cards_with_no_rewards_to_na
      Card.where.not(:id => Reward.select(:card_id).uniq).update_all(best_offer: 'n/a')
    end
  end
  BestCards.new
end