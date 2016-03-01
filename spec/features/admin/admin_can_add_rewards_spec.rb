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
    click_on "Submit Reward Information"

    expect(current_path).to eq(edit_admin_card_path(card_one))

    within('.table') do
      expect(page).to have_content("5000")
      expect(page).to have_content("$3,000")
      expect(page).to have_content("2016-02-18")
      expect(page).to have_content("3")
      expect(page).to have_content("www.test.com")
    end
  end

  scenario "rewards will show up on card show page if the card is has rewards regardless of category" do
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
    click_on "Submit Reward Information"

    within(".table") do
      expect(page).to have_content("60000")
      expect(page).to have_content("$4,000")
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

    within(".bonus-information-side") do
      expect(page).to have_content("60000")
      expect(page).to have_content("$4,000")
      expect(page).to have_content("4 Months")

      expect(page).to_not have_content("50000")
      expect(page).to_not have_content("$3,000")
      expect(page).to_not have_content("3 Months")
    end
  end

  scenario "rewards will not show up on card show page if the card has no rewards" do
    set_card_categories
    visit card_path(card_one)

    within(".bonus-information") do
      expect(page).to have_content("No Bonus Information")
      click_on "Click Here for Cards with Bonus Information!"
      expect(current_path).to eq("/best-credit-card-offers")
    end
  end
end