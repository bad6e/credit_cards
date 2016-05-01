require "rails_helper"

feature "user - card show page" do
  include_context "features"

  scenario "if the card has related blog posts - they appear on the page", js: true do
    set_card_categories
    set_blog_categories
    visit card_path(card_one)
    expect(page).to have_content("Related Blog Posts")
    expect(page).to have_content("Omg The Southwest Companion Pass: How to Travel for Free")
  end

  scenario "if the card has NO related blogs posts - the related blogs posts do not appear on the page" do
    set_card_categories
    visit card_path(card_one)
    expect(page).to_not have_content("Related Blog Posts")
    expect(page).to_not have_content("Omg The Southwest Companion Pass: How to Travel for Free")
  end

  scenario "if the user clicks the blog post they are directed to the blog post", js: true do
    set_card_categories
    set_blog_categories
    visit card_path(card_one)
    within(".title-link") do
      click_on "Omg The Southwest Companion Pass: How to Travel for Free"
    end
    expect(current_path).to eq(blog_path(blog_one))
  end

  scenario "if the admin HAS NOT published a blog postarticle -- it does not show up related card show page", js: true do
    blog = Blog.find_by(meta_title: 'Omg The Southwest Companion Pass: How to Travel for Free ')
    blog.update(published: false)
    set_card_categories
    visit card_path(card_one)
    expect(page).to_not have_content("Related Blog Posts")
    expect(page).to_not have_content("Omg The Southwest Companion Pass: How to Travel for Free")
  end
end