require 'rails_helper'

RSpec.describe TransferPartner, type: :model do
  subject { create(:transfer_partner) }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:image_url) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:image_url) }

  it { should have_many(:card_programs) }
  it { should have_many(:cards) }
  it { should have_many(:card_program_transfer_partners) }
end