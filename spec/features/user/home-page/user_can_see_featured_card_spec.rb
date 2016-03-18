require "rails_helper"
require 'rake'
Rake::Task.clear
CreditCards::Application.load_tasks

feature "home page" do
  include_context "features"

  scenario "user can see featured card as an example" do
    set_card_categories
    visit root_path
    expect(page).to have_content("Starwood's Sign Up Bonus Over Time")
  end
end