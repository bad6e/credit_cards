class Api::V1::SearchSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :annual_fee,
             :apr,
             :intro_rate,
             :image_link,
             :best_offer,
             :credit_score,
             :point_type

  has_many :rewards

  def rewards
    object.rewards.order('record_date DESC')
  end
end
