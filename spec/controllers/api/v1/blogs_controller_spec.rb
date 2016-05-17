require 'rails_helper'

RSpec.describe Api::V1::BlogsController, type: :controller do

  describe "GET /api/v1/blogs" do
    it "returns all the blogs where published equals true in desc order" do
    blog_one = Blog.create(meta_title: "Sup Friends I like travel",
                 meta_description: "This is the best deal ever!",
                 image_url: "https://s3.amazonaws.com/card-facebook-images/southwest/bigstock-Southwest-Boeing---36166444.jpg",
                 published: true)


      blog_two = Blog.create(meta_title: "Sup Friends I like travel Part II",
                 meta_description: "This is the best deal ever!",
                 image_url: "https://s3.amazonaws.com/card-facebook-images/southwest/bigstock-Southwest-Boeing---36166444.jpg",
                 published: true)

      blog_three = Blog.create(meta_title: "Sup Friends I like travel Part III",
                 meta_description: "This is the best deal ever!",
                 image_url: "https://s3.amazonaws.com/card-facebook-images/southwest/bigstock-Southwest-Boeing---36166444.jpg",
                 published: false)

      get :index, format: :json
      expect(response_data.length).to eq(2)
      expect(response_data[0]['meta_title']).to eq("Sup Friends I like travel Part II")
      expect(response_data[1]['meta_title']).to eq("Sup Friends I like travel")
    end
  end
end