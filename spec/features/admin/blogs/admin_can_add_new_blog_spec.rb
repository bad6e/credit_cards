require "rails_helper"

feature "admin - blogs" do
  include_context "features"

  scenario "admin can add new blog and assign it to related cards" do
    admin_login
    visit admin_blogs_path

    click_on "Add a New Blog"
    expect(current_path).to eq(new_admin_blog_path)
    expect(page).to have_content("Add New Blog Here")

    fill_in "blog[meta_title]", with: "Test Blog Name"
    fill_in "blog[meta_description]", with: "This is a test description"
    fill_in "blog[image_url]", with: "https://s3.amazonaws.com/card-facebook-images/southwest/bigstock-Southwest-Boeing---36166444.jpg"
    select card_one.name, :from => "blog[cards][]"
    select card_two.name, :from => "blog[cards][]"

    click_on "Submit Blog"

    expect(current_path).to eq(admin_blogs_path)

    expect(card_one.blogs.first.meta_title).to eq("Test Blog Name")
    expect(card_one.blogs.first.slug).to eq("test-blog-name")
    expect(card_two.blogs.first.meta_title).to eq("Test Blog Name")

    visit admin_blogs_path
    expect(page).to have_content("Test Blog Name")
  end
end