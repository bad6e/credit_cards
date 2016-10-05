class CardProgramTransferPartner < ActiveRecord::Base
  belongs_to :card
  belongs_to :card_program
  belongs_to :transfer_partner
end
