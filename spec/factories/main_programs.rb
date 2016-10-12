FactoryGirl.define do
  factory :main_program do
    name { Faker::Company.name }
    image_url { Faker::Internet.url }
  end
end