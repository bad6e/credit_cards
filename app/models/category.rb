class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :categorizings
  has_many :cards, through: :categorizings

  validates :name,
    presence: true

  def parse_category_name
    display_name = self.name.gsub("-", " ").titleize
  end

  def self.exclude_ids
    cat_1 = Category.find_by(name: "brets-favorite-cards")
    cat_2 = Category.find_by(name: "best-credit-card-offers")
    cat_3 = Category.find_by(name: "other-credit-cards")
    [cat_1.id, cat_2.id, cat_3.id]
  end
end
