require 'rails_helper'

RSpec.describe CardProgramTransferPartner, type: :model do
  subject { create(:card_program_transfer_partner) }

  it { should be_valid }

  it { should respond_to(:card_id) }
  it { should respond_to(:card_program_id) }
  it { should respond_to(:transfer_partner_id) }

  it { should belong_to(:card) }
  it { should belong_to(:card_program) }
  it { should belong_to(:transfer_partner) }
end
