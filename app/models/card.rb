class Card < ActiveRecord::Base
  has_many :rewards, dependent: :destroy

  has_many :categorizings
  has_many :categories, through: :categorizings

  has_many :favorite_cards
  has_many :users, through: :favorite_cards

  has_many :card_blogs
  has_many :blogs, through: :card_blogs

  has_many :card_program_transfer_partners
  has_many :transfer_partners, through: :card_program_transfer_partners

  belongs_to :card_program, class_name: "CardProgram"
  belongs_to :main_program, class_name: "CardProgram"

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

  scope :find_cards_that_are_in_multiple_categories, ->(category_names) { where(id: Card.cards_with_multiple_categories(category_names)) }

  def self.cards_with_multiple_categories(category_names)
    joins(:categories)
    .where('categories.name' => category_names)
    .group(:id)
    .having('count(categories.name) >= ?', category_names.length)
  end

  def parse_card_categories_name
    name = self.categories.map do |category|
      category.name.gsub("-", " ").titleize
    end
  end

  def self.search(params)
    where("name LIKE ?", "%#{params}%")
  end
end

