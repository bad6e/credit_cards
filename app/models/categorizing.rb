class Categorizing < ActiveRecord::Base
  belongs_to :category
  belongs_to :card

  validates :card_id, presence: true
  validates :category_id, presence: true
end
