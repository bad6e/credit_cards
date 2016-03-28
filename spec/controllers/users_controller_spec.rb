require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @user_one  = User.create(first_name: "Bret",
                             last_name: "Doucette",
                             email: "test@test.com",
                             password: "password",
                             name: "Bret Doucette",
                             role: 1)
  end

  describe "PUT /users/:id" do

    it "updates a user's email and updated_email status" do
      put :update, id: @user_one.id, user: { email: "bret@toomanymiles.com"}
      user = User.find_by(first_name: "Bret")
      expect(user.email).to eq("bret@toomanymiles.com")
      expect(user.updated_email).to eq(true)
    end

    it "will not update a user's email or status if the params are blank" do
      put :update, id: @user_one.id, user: { email: ""}
      user = User.find_by(first_name: "Bret")
      expect(user.email).to eq("test@test.com")
      expect(user.updated_email).to eq(nil)
    end
  end
end

