require 'rails_helper'

RSpec.describe MainProgram, type: :model do
  subject { create(:main_program) }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:image_url) }

  it { should validate_presence_of(:name) }

  it { should have_many (:main_program_card_programs)}
  it { should have_many (:card_programs)}
end