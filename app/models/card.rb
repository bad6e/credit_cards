class Card < ActiveRecord::Base
  has_many :rewards

  has_many :categorizings
  has_many :categories, through: :categorizings

  has_many :favorite_cards
  has_many :users, through: :favorite_cards

  has_many :card_blogs
  has_many :blogs, through: :card_blogs

  has_many :card_program_transfer_partners
  has_many :transfer_partners, through: :card_program_transfer_partners

  belongs_to :card_program, class_name: "CardProgram"
  belongs_to :main_program, class_name: "MainProgram"

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
  scope :exclude_cash_and_other_cards, -> { joins(:categories).where.not({categories: {id: [5,6]}}) }
  scope :name_like, ->(params) { where("cards.name LIKE ?", "%#{params}%") }

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
    exclude_cash_and_other_cards.name_like(params).uniq
  end

  def self.card_names
    exclude_cash_and_other_cards.pluck(:id, :name).uniq
  end
end

