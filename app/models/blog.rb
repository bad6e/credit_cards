class Blog < ActiveRecord::Base
  has_many :card_blogs
  has_many :cards, through: :card_blogs

end
