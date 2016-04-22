require 'rails_helper'

RSpec.describe Api::V1::RelatedBlogsController, type: :controller do
  include_context "features"

  describe "GET /api/v1/related_blogs/:card_id"

  it "returns all the blogs associated with a card in DESC order" do
    blog_one = Blog.create(meta_title: "Southwest Companion Pass",
                           meta_description: "This is the best deal ever!",
                           image_url: "https://s3.amazonaws.com/card-facebook-images/southwest/bigstock-Southwest-Boeing---36166444.jpg")

    blog_two = Blog.create(meta_title: "What is New with Jet Blue",
                           meta_description: "This is the best deal ever!",
                           image_url: "https://s3.amazonaws.com/card-facebook-images/southwest/bigstock-Southwest-Boeing---36166444.jpg")


    card_one = Card.create(name: "Southwest Airlines Rapid Rewards® Premier Credit Card",
                           annual_fee: "$99",
                           information: ["Bullet A", "Bullet B"],
                           apr: "12%",
                           intro_rate: "N/A",
                           image_link: "https://www.google.com/?gws_rd=ssl",
                           point_type: "Southwest Rapid Rewards®")

    card_one.blogs << blog_one
    card_one.blogs << blog_two

    get :show, id: card_one.id, format: :json
    expect(response_data.length).to eq(2)
    expect(response_data[0]["meta_title"]).to eq("What is New with Jet Blue")
    expect(response_data[1]["meta_title"]).to eq("Southwest Companion Pass")
  end
end
