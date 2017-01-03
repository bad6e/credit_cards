class Blog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :meta_title, use: :slugged

  has_many :card_blogs
  has_many :cards, through: :card_blogs

  validates :meta_title,
    presence: true,
    uniqueness: true,
    length: { maximum: 85}

  validates :meta_description,
    presence: true,
    length: { maximum: 160}

  scope :find_blogs_with_cards_associated, -> (ids) { joins(:cards).where(cards: { id: ids }) }

  def self.find_related_blogs_exclude_current_blog(card_ids, current_blog_id)
    find_blogs_with_cards_associated(card_ids)
    .where.not(id: current_blog_id)
    .order(created_at: :desc)
    .limit(3)
    .uniq
  end

  def self.find_related_blogs(card_id)
    find_blogs_with_cards_associated(card_id)
    .order(created_at: :desc)
    .limit(3)
    .uniq
  end

  def self.parameterize_slug(blog)
    blog.update(slug: blog.meta_title.parameterize)
  end
end
