require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:blog) {
    Blog.create(meta_title: "Jet Blues Newest Card - My Review",
                meta_description: 3000,
                title: "Jet Blues Newest Card - My Review")
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

  it "is invalid with a title over 60 characters" do
    blog.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio"
    expect(blog).to be_invalid
  end

  it "is invalid with a meta_description over 160 characters" do
    blog.meta_description = "Lorem nec odio Lorem ipsum dolor sit amet, consectetur orem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio Lorem ips adipiscing elit. Integer nec odio"
    expect(blog).to be_invalid
  end
end
