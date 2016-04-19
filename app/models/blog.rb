class Blog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :meta_title, use: :slugged
  after_create :slug_meta_title
  has_many :card_blogs
  has_many :cards, through: :card_blogs

  validates :meta_title,
    presence: true,
    uniqueness: true,
    length: { maximum: 60}

  validates :meta_description,
    presence: true,
    length: { maximum: 160}

  def slug_meta_title
    self.update(slug: meta_title.parameterize)
  end
end
