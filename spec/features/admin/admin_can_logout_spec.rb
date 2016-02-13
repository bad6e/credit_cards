require "rails_helper"

feature "admin" do
  include_context "features"

  scenario "admin can log out" do
    admin_login
    expect(current_path).to eq(admin_cards_path)
    click_on "Logout"
    expect(current_path).to eq(root_path)
  end
end
