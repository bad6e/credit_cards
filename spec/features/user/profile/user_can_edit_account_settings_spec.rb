require "rails_helper"

feature "User Profile Page" do
  include_context "features"

  scenario "user can delete their account", js: true do
    login_with_facebook
    click_on "ACCOUNT"
    expect(User.all.count).to eq(2)
    within(".update-settings") do
      click_on "DELETE ACCOUNT"
      page.driver.browser.switch_to.alert.accept
    end
    expect(page).to have_content("We are sorry to see you go, Example User!")
    expect(current_path).to eq(root_path)
    expect(User.all.count).to eq(1)
  end
end