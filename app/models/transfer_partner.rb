class TransferPartner < ActiveRecord::Base
  has_many :card_program_transfer_partners
  has_many :card_programs, through: :card_program_transfer_partners
  has_many :cards, through: :card_program_transfer_partners
end
