class CardSerializer < ActiveModel::Serializer
  attributes :id, :name, :annual_fee, :apr, :intro_rate, :image_link, :best_offer, :credit_score
  has_many :rewards
  has_many :favorite_card_ids


  def rewards
    object.rewards.order('record_date DESC')
  end

  def favorite_card_ids
    if current_user
      current_user.cards.map {|card| card.id}
    end
  end
end

