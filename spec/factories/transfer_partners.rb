FactoryGirl.define do
  factory :transfer_partner do
    name { Faker::Company.name }
    image_url { Faker::Internet.url }
  end
end