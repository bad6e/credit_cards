class Blog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :meta_title, use: :slugged

  has_many :card_blogs
  has_many :cards, through: :card_blogs

  validates :meta_title,
    presence: true,
    uniqueness: true,
    length: { maximum: 75}

  validates :meta_description,
    presence: true,
    length: { maximum: 160}


  def self.parameterize_slug(blog)
    blog.update(slug: blog.meta_title.parameterize)
  end
end
