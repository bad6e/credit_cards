require "rails_helper"

feature "admin" do
  include_context "features"

  scenario "admin can edit existing rewards" do
    set_card_categories
    admin_edit
    fill_in_reward_information
    expect(current_path).to eq(edit_admin_card_path(card_one))

    visit admin_cards_path

    within("#card-#{card_one.id}") do
      first(:link, "Edit").click
    end

    within(".reward-table") do
      first(:link, "Edit").click
    end

    expect(current_path).to eq(edit_admin_reward_path(card_one.rewards.first))

    fill_in "reward[amount]", with: 45000
    fill_in "reward[apply_link]", with: "www.test1.com"
    click_on "Submit Reward Information"

    within(".table") do
      expect(page).to have_content("45000")
      expect(page).to have_content("$3,000")
      expect(page).to have_content("2016-02-18")
      expect(page).to have_content("3")
      expect(page).to have_content("www.test1.com")
    end

    card_one.categories << Category.find(category_five.id)
    visit card_path(card_one)

    within(".bonus-information") do
      expect(page).to have_content("45000")
      expect(page).to have_content("$3,000")
      expect(page).to have_content("3 Months")
    end
  end
end