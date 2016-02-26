require "rails_helper"

feature "admin-csv" do
  include_context "features"

  before(:each) do
     Reward.create(amount: 50000,
                   length_of_time: 2,
                   record_date: "2016-02-18",
                   spending_amount: 2000,
                   apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                   card_id: card_one.id)

     Reward.create(amount: 40000,
                   length_of_time: 2,
                   record_date: "2016-02-11",
                   spending_amount: 2000,
                   apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                   card_id: card_one.id)
   end

  scenario "admin can upload a file" do
    admin_login
    set_card_categories

    c1 = Card.find(card_one.id)
    c1.categories << Category.find(category_five.id)

    within (".upload-file") do
      expect(page).to have_button("Import CSV")
      attach_file('file', Rails.root.to_s + "/spec/fixtures/card-test.csv")
      fill_in "date", with: "2016-03-16"
      click_on "Import CSV"
    end

    rewards = card_one.rewards
    expect(rewards.count).to eq(3)
    expect(rewards.last.record_date.to_s).to eq("2016-03-16")

    visit card_path(card_one)

    within(".bonus-information") do
      expect(page).to have_content "50100"
      expect(page).to have_content "2"
      expect(page).to have_content "$2,500"
    end

    within(".card-info-box") do
      expect(page).to have_content "$101"
    end
  end
end




#   xscenario "user uploads improperly formatted file" do
#     enter_password
#     visit upload_path
#     within("#upload") do
#       attach_file('file', Rails.root.to_s + '/spec/fixtures/incorrect_format.csv')
#       click_on("Upload File")
#     end
# ​
#     expect(current_path).to eq(upload_path)
#     within("#flash-message") do
#       expect(page).to have_content("There was a problem with: Question 3. Student 2.")
#     end
#   end
#
# end