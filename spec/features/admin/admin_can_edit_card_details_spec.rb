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

  scenario "admin can edit card details and see updated card show page" do
    set_card_categories
    admin_edit

    fill_in "card[name]", with: "Test Name1"
    fill_in "card[annual_fee]", with: "$99"
    fill_in "card[apr]", with: "12.99%"
    fill_in "card[intro_rate]", with: "N/A"
    fill_in "card[image_link]", with: "www.himom.com"
    fill_in "card[information]", with: "This is the best card ever. I really like it. Fact."
    click_on "Submit Information"

    expect(current_path).to eq(admin_cards_path)

    within("#card-#{card_one.id}") do
      first(:link, "Edit").click
    end

    within(".edit_card") do
      find_field('card[name]').value.should eq "Test Name1"
      find_field('card[annual_fee]').value.should eq "$99"
      find_field('card[apr]').value.should eq "12.99%"
      find_field('card[intro_rate]').value.should eq "N/A"
      find_field('card[image_link]').value.should eq "www.himom.com"
      find_field('card[information]').value.should eq "This is the best card ever.  I really like it.  Fact."
    end

    visit card_path(card_one)
    expect(page).to have_content("Test Name1")
    expect(page).to have_content("$99")
    expect(page).to have_content("12.99%")
    expect(page).to have_content("N/A")

    within(".card-description") do
      expect(page).to have_css('ul')
      expect(page).to have_content("This is the best card ever.")
      expect(page).to have_content("I really like it.")
      expect(page).to have_content("Fact.")
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
