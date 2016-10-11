require 'rails_helper'

RSpec.describe CardProgram, type: :model do
  subject { create(:card_program) }

  it { should be_valid }

  it { should respond_to(:name) }

  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:name) }

  it { should have_many(:cards) }
  it { should have_many(:card_program_transfer_partners) }
  it { should have_many(:transfer_partners) }
end