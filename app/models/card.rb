class Card < ActiveRecord::Base
  has_many :categorizings
  has_many :categories, through: :categorizings
end
