class CardSerializer < ActiveModel::Serializer
  attributes :id, :name, :annual_fee, :apr, :intro_rate, :image_link, :best_offer
  has_many :rewards

  def rewards
    object.rewards.order('record_date DESC')
  end
end

