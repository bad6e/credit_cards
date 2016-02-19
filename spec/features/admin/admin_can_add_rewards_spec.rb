require "rails_helper"

feature "admin" do
  include_context "features"

  scenario "admin can add rewards for a specific card" do
    admin_edit

    click_on "Add Another Reward for #{card_one.name}"

    expect(current_path).to eq(new_admin_reward_path)
    expect(page).to have_content("Add a New Reward for #{card_one.name}")

    fill_in "reward[amount]", with: 50000
    fill_in "reward[spending_amount]", with: 3000
    fill_in "reward[record_date]", with: "2016-02-18"
    fill_in "reward[length_of_time]", with: 3
    fill_in "reward[apply_link]", with: "www.test.com"
    click_on "Add New Reward"

    expect(current_path).to eq(edit_admin_card_path(card_one))

    within('.table') do
      expect(page).to have_content("5000")
      expect(page).to have_content("$3,000.00")
      expect(page).to have_content("2016-02-18")
      expect(page).to have_content("3")
      expect(page).to have_content("www.test.com")
    end
  end

  scenario "rewards will show up on card show page if in category 'Bret's Favortie Cards'" do
    set_card_categories
    admin_edit
    fill_in_reward_information
    expect(current_path).to eq(edit_admin_card_path(card_one))

    visit admin_cards_path

    within("#card-#{card_one.id}") do
      first(:link, "Edit").click
    end

    click_on "Add Another Reward for #{card_one.name}"
    fill_in "reward[amount]", with: 60000
    fill_in "reward[spending_amount]", with: 4000
    fill_in "reward[record_date]", with: "2016-02-19"
    fill_in "reward[length_of_time]", with: 4
    fill_in "reward[apply_link]", with: "www.test1.com"
    click_on "Add New Reward"

    within(".table") do
      expect(page).to have_content("60000")
      expect(page).to have_content("$4,000.00")
      expect(page).to have_content("2016-02-19")
      expect(page).to have_content("4")
      expect(page).to have_content("www.test1.com")
    end
    card_one.categories << Category.find(category_five.id)
    visit card_path(card_one)

    within(".bonus-information") do
      expect(page).to have_content("60000")
      expect(page).to have_content("$4,000")
      expect(page).to have_content("4 Months")

      expect(page).to_not have_content("50000")
      expect(page).to_not have_content("$3,000")
      expect(page).to_not have_content("3 Months")
    end

  end
end