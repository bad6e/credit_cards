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

  after_create :find_previous_reward_with_cent_value

  def find_previous_reward_with_cent_value
    most_recent_reward = Reward.where('card_id = ? AND cent_value > ?', self.card_id, 0).order(record_date: :desc).first
    set_cent_dollar_value_if_reward(most_recent_reward)
  end

  def set_cent_dollar_value_if_reward(most_recent_reward)
    if most_recent_reward
      self.update(cent_value: most_recent_reward.cent_value, dollar_amount: most_recent_reward.cent_value * self.amount)
    end
  end
end
