FactoryGirl.define do
  factory :reward do
    amount { 50000 }
    spending_amount { Faker::Internet.url }
    record_date { "2016-02-17" }
    card_id { FactoryGirl.create(:cards).id }
    length_of_time { 3 }
    apply_link { Faker::Internet.url }
    dollar_amount { 1000 }
    cent_value { 0.05 }
    reward_type { nil}
  end
end
