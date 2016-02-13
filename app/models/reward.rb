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
end
