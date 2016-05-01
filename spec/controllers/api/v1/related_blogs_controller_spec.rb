require 'rails_helper'

RSpec.describe Api::V1::RelatedBlogsController, type: :controller do
  include_context "features"

  describe "GET /api/v1/related_blogs/:card_id" do
    it "returns all the blogs associated with a card in DESC order where published equals true" do

      blog_one = Blog.create(meta_title: "Sup Friends I like travel",
                 meta_description: "This is the best deal ever!",
                 image_url: "https://s3.amazonaws.com/card-facebook-images/southwest/bigstock-Southwest-Boeing---36166444.jpg",
                 published: true)

      blog_one.cards << card_one

      blog_two = Blog.create(meta_title: "Sup Friends I like travel Part II",
                 meta_description: "This is the best deal ever!",
                 image_url: "https://s3.amazonaws.com/card-facebook-images/southwest/bigstock-Southwest-Boeing---36166444.jpg",
                 published: true)

      blog_two.cards << card_one

      blog_three = Blog.create(meta_title: "Sup Friends I like travel Part III",
                 meta_description: "This is the best deal ever!",
                 image_url: "https://s3.amazonaws.com/card-facebook-images/southwest/bigstock-Southwest-Boeing---36166444.jpg",
                 published: false)

      blog_three.cards << card_one

      get :show, id: card_one.id, format: :json
      expect(response_data.length).to eq(2)
      expect(response_data[0]['meta_title']).to eq("Sup Friends I like travel Part II")
      expect(response_data[1]['meta_title']).to eq("Sup Friends I like travel")


    end



  end
end