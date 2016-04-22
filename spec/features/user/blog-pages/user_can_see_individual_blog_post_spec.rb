require "rails_helper"

feature "user - blog show page" do
  include_context "features"

  scenario "user can see individual blog posts from Wordpress API", js: true do
    visit blog_path(blog_one)
    expect(page).to have_content("The Southwest Companion Pass: How to Travel for Free")
  end
end