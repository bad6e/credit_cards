class CardSerializer < ActiveModel::Serializer
  attributes :id, :name, :annual_fee, :apr, :intro_rate, :image_link, :best_offer, :credit_score, :point_type
  has_many :rewards
  has_many :favorite_card_ids
  has_one :search_term


  def rewards
    object.rewards.order('record_date DESC')
  end

  def favorite_card_ids
    if current_user
      current_user.cards.map {|card| card.id}
    end
  end

  def search_term
    @instance_options[:search_term]
  end
end

