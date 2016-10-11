FactoryGirl.define do
  factory :card do
    name { Faker::Company.name }
    annual_fee { "$95 "}
    information { ["Earn 50,000 points after you spend $2,000 on purchases in the first 3 months your account is open", "Chip-enabled cards with 24/7 fraud monitoring"] }
    apr { "19.82%" }
    intro_rate { "N/A" }
    image_link { Faker::Internet.url }
    best_offer { ['Yes','No'].sample }
    flyer_talk_link { Faker::Internet.url }
    point_type { "Southwest Rapid Reward" }
    image_url { Faker::Internet.url }
    card_program_id { FactoryGirl.create(:card_program).id }
  end
end