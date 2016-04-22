require "rails_helper"

feature "user - blog index page" do
  include_context "features"

  scenario "user can see all the blogs from Wordpress API", js: true do
    visit blogs_path
    expect(page).to have_content("Blog Posts on Too Many Miles")
    expect(page).to have_content("Continue Reading")
    expect(page).to have_content("LOAD MORE POSTS")
  end
end

