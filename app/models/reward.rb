class Reward < ActiveRecord::Base
  belongs_to :card

  validates :amount,
    presence: true

  validates :spending_amount,
    presence: true

  validates :record_date,
    presence: true

  validates :length_of_time,
    presence: true

  after_create :set_cent_and_dollar_value

  def set_cent_and_dollar_value
    most_recent_reward = Reward.where('card_id = ? AND cent_value > ?', 40, 0).order(record_date: :desc).first
    self.update(cent_value: most_recent_reward.cent_value, dollar_amount: most_recent_reward.cent_value * most_recent_reward.amount)
  end
end
