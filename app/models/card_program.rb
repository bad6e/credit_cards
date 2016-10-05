class CardProgram < ActiveRecord::Base
  has_many :cards
  has_many :card_program_transfer_partners
  has_many :transfer_partners, through: :card_program_transfer_partners
end
