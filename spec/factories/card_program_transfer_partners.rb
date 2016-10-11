FactoryGirl.define do
  factory :card_program_transfer_partner do
    card_id { FactoryGirl.create(:card).id }
    card_program_id { FactoryGirl.create(:card_program).id }
    transfer_partner_id { FactoryGirl.create(:transfer_partner).id }
  end
end