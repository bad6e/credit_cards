require "rails_helper"

feature "admin" do
  include_context "features"

  scenario "admin see card edit form" do
    admin_login

    within("#card-#{card_one.id}") do
      first(:link, "Edit").click
    end

    expect(current_path).to eq(edit_admin_card_path(card_one))
    expect(page).to have_content("Card Details")
    expect(page).to have_content("Card Categories")
    expect(page).to have_content("Card Rewards")
  end

  scenario "admin can edit basic card details" do
    admin_edit

    fill_in "card[name]", with: "Test Name1"
    fill_in "card[annual_fee]", with: "Test Name2"
    fill_in "card[apr]", with: "Test Name3"
    fill_in "card[intro_rate]", with: "Test Name4"
    fill_in "card[image_link]", with: "Test Name5"
    click_on "Update Card"

    expect(current_path).to eq(admin_cards_path)

    within("#card-#{card_one.id}") do
      first(:link, "Edit").click
    end

    within(".edit_card") do
      find_field('card[name]').value.should eq 'Test Name1'
      find_field('card[annual_fee]').value.should eq 'Test Name2'
      find_field('card[apr]').value.should eq 'Test Name3'
      find_field('card[intro_rate]').value.should eq 'Test Name4'
      find_field('card[image_link]').value.should eq 'Test Name5'
    end
  end

  scenario "admin can add rewards for a specific card" do
    admin_edit

    click_on "Add Another Reward for #{card_one.name}"

    expect(current_path).to eq(new_admin_reward_path)
    expect(page).to have_content("Add a New Reward for #{card_one.name}")

    fill_in "reward[amount]", with: 50000
    fill_in "reward[spending_amount]", with: 3000
    fill_in "reward[record_date]", with: "2016-02-18"
    fill_in "reward[length_of_time]", with: 3
    click_on "Add New Reward"

    expect(current_path).to eq(edit_admin_card_path(card_one))
    within('.table') do
      expect(page).to have_content("5000")
      expect(page).to have_content("$3,000.00")
      expect(page).to have_content("2016-02-18")
      expect(page).to have_content("3")
    end
  end
 end
