class Card < ActiveRecord::Base
  has_many :categorizings
  has_many :categories, through: :categorizings
  has_many :bonus

  validates :name, presence: true, uniqueness: true
  validates :annual_fee, presence: true
  validates :information, presence: true
  validates :apr, presence: true
  validates :intro_rate, presence: true
  validates :image_link, presence: true, uniqueness: true

  def parse_name
    name = self.categories.first.name
    display_name = name.gsub("-", " ").titleize
  end
end
