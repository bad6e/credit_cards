class Card < ActiveRecord::Base
  has_many :rewards, dependent: :destroy

  has_many :categorizings
  has_many :categories, through: :categorizings

  accepts_nested_attributes_for :categories,
                                  reject_if: :all_blank,
                                  allow_destroy: true

  accepts_nested_attributes_for :rewards,
                                reject_if: proc { |attributes| attributes['amount'].blank? },
                                allow_destroy: true

  validates :name,
              presence: true,
              uniqueness: true
  validates :annual_fee,
              presence: true
  validates :apr,
              presence: true
  validates :intro_rate,
              presence: true
  validates :image_link,
              presence: true,
              uniqueness: true

  def parse_card_name
    name = self.categories.first.name
    display_name = name.gsub("-", " ").titleize
  end

  def convert_form_information(params)
    binding.pry
  end
end

