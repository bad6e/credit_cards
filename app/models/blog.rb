class Blog < ActiveRecord::Base
  has_many :card_blogs
  has_many :cards, through: :card_blogs

  validates :meta_title,
    presence: true,
    uniqueness: true,
    length: { maximum: 60}

  validates :meta_description,
    presence: true,
    length: { maximum: 160}

  validates :title,
    presence: true,
    uniqueness: true,
    length: { maximum: 60}

  validates :author,
    presence: true
end
