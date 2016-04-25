require "rails_helper"

feature "User Profile Page" do
  include_context "features"

  scenario "user can delete their account", js: true do
    User.delete_all
    expect(User.all.count).to eq(0)
    login_with_facebook
    click_on "0 Favorite Cards"
    expect(User.all.count).to eq(1)
    within(".delete-account") do
      click_on "DELETE ACCOUNT"
      page.driver.browser.switch_to.alert.accept
    end
    expect(page).to have_content("We are sorry to see you go, Bret Doucette!")
    expect(current_path).to eq(root_path)
    expect(User.all.count).to eq(0)
  end

  scenario "user can see their email in the field", js: true do
    admin_login
    click_on "0 Favorite Cards"
    within(".edit_user") do
      expect(find_field('user[email]').value).to eq("test@test.com")
    end
  end
end