class User < ActiveRecord::Base
  has_secure_password

  has_many :favorite_cards
  has_many :cards, through: :favorite_cards

  enum role: ["default", "admin"]

  validates :name,
              presence: true

  validates :email,
              presence: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def self.from_omniauth(auth_hash)
    user                 = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name            = auth_hash['info']['name']
    user.email           = set_email(auth_hash, user)
    first_time_login?(user)
    user.password_digest = SecureRandom.urlsafe_base64
    user.location        = auth_hash['info']['location']
    user.image_url       = auth_hash['info']['image']
    user.url             = auth_hash['info']['urls']
    user.save!
    user
  end

  def self.first_time_login?(user)
    if user.password_digest == nil
      UserMailer.welcome_email(user).deliver
    end
  end

  def self.set_email(auth_hash, user)
    if user.updated_email != true
      auth_hash['info']['email']
    else
      user.email
    end
  end
end



