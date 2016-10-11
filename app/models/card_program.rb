class CardProgram < ActiveRecord::Base
  has_many :cards
  has_many :card_program_transfer_partners
  has_many :transfer_partners, through: :card_program_transfer_partners

  has_many :main_program_card_programs
  has_many :main_programs, through: :main_program_card_programs

  validates :name,
              presence: true,
              uniqueness: true
end
