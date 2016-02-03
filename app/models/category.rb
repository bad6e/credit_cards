class Category < ActiveRecord::Base
  has_many :categorizings
  has_many :cards, through: :categorizings
end
