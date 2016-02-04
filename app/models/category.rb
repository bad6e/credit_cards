class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :categorizings
  has_many :cards, through: :categorizings

  validates :name, presence: true, uniqueness: true

  def parse_category_name
    display_name = self.name.gsub("-", " ").titleize
  end
end
