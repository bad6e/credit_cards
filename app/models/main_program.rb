class MainProgram < ActiveRecord::Base
  has_many :main_program_card_programs
  has_many :card_programs, through: :main_program_card_programs

  validates :name,
    presence: true,
    uniqueness: true
end