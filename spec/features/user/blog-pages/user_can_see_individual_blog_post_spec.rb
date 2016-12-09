require "rails_helper"

feature "user - blog show page" do
  include_context "features"

  scenario "user can see individual blog posts from Wordpress API", js: true do
    visit blog_path(blog_one)
    sleep(2)
    expect(page).to have_content("The Southwest Companion Pass: How to Travel for Free")
    expect(page).to have_content("Cards Mentioned in this Blog")
    expect(page).to have_content("Southwest Airlines Rapid Rewards® Premier Credit Card")
  end
end
