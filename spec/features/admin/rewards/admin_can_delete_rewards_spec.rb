require "rails_helper"

feature "admin" do
  include_context "features"

  scenario "admin can delete existing rewards" do
    set_card_categories
    admin_edit
    fill_in_reward_information
    expect(current_path).to eq(edit_admin_card_path(card_one))

    visit admin_cards_path

    within("#card-#{card_one.id}") do
      first(:link, "Edit").click
    end

    within(".reward-table") do
      first(:link, "Delete").click
    end

    expect(current_path).to eq(edit_admin_card_path(card_one))
    expect(page).to have_content("This card has no rewards!")
  end
end