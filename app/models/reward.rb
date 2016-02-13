class Reward < ActiveRecord::Base
  belongs_to :card

  validates :amount,
    presence: true

  validates :spending_amount,
    presence: true

end
