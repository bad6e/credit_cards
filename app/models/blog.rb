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


  def self.parameterize_slug(blog)
    blog.update(slug: blog.meta_title.parameterize)
  end

  def self.recent_blogs(excluded_blog, number)
    where.not(id: excluded_blog.id).order('created_at DESC').limit(number)
  end

  def self.send_blog_email(blog, user)
    UserMailer.delay.blog_email(blog, user,  Blog.recent_blogs(blog, 3))
  end
end
