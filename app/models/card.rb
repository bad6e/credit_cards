class Card < ActiveRecord::Base
  has_many :rewards, dependent: :destroy

  has_many :categorizings
  has_many :categories, through: :categorizings

  accepts_nested_attributes_for :categories,
                                  reject_if: :all_blank,
                                  allow_destroy: true

  validates :name,
              presence: true
  validates :annual_fee,
              presence: true
  validates :apr,
              presence: true
  validates :intro_rate,
              presence: true
  validates :image_link,
              presence: true

  self.per_page = 10

  def parse_card_categories_names
    name = self.categories.map do |category|
      category.name.gsub("-", " ").titleize
    end
  end

  def self.search(params)
    where("name LIKE ?", "%#{params}%")
  end
end

