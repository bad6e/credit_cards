class Card < ActiveRecord::Base
  has_many :categorizings
  has_many :categories, through: :categorizings

  def parse_name
    name = self.categories.first.name
    display_name = name.gsub("-", " ").titleize
  end
end
