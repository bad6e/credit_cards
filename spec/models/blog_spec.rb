require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:blog) {
    Blog.create(meta_title: "Jet Blues Newest Card My Review",
                meta_description: 3000)
  }

  it "is valid" do
    expect(blog).to be_valid
  end

  it "is invalid without a meta_title" do
    blog.meta_title = nil
    expect(blog).to be_invalid
  end

  it "is invalid without a meta meta_description" do
    blog.meta_description = nil
    expect(blog).to be_invalid
  end

  it "is invalid with a meta_title over 60 characters" do
    blog.meta_title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio"
    expect(blog).to be_invalid
  end

  it "is invalid with a meta_description over 160 characters" do
    blog.meta_description = "Lorem nec odio Lorem ipsum dolor sit amet, consectetur orem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio Lorem ips adipiscing elit. Integer nec odio"
    expect(blog).to be_invalid
  end

  it "automatically creates a parameterized slug on CREATE" do
    expect(blog.slug).to eq("jet-blues-newest-card-my-review")
  end

  it "creates a parameterized slug from Blogs Controller" do
    blog.meta_title = "Hello World"
    Blog.parameterize_slug(blog)
    expect(blog.slug).to eq("hello-world")
  end

  it "defaults to a value of published to false" do
    expect(blog.published).to eq(false)
  end
end
