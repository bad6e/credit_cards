class CardBlog < ActiveRecord::Base
  belongs_to :card
  belongs_to :blog

  validates :card_id,
              presence: true
  validates :blog_id,
              presence: true
end
