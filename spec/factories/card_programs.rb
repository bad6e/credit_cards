FactoryGirl.define do
  factory :card_program do
    name { Faker::Company.name }
    image_url { Faker::Internet.url }
  end
end
