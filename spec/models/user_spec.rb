require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.create(first_name: "Bret",
                last_name: "Doucette",
                email: "bad6e@virginia.edu",
                password: "password",
                name: "Bret Doucette",
                role: 1)
  }

  let(:auth_hash) {
    {"provider"=>"facebook",
 "uid"=>"10102599568380936",
 "info"=>
  {"email"=>"doucette.bret@gmail.com",
   "name"=>"Bret Doucette",
   "image"=>"http://graph.facebook.com/10102599568380936/picture",
   "urls"=>{"Facebook"=>"https://www.facebook.com/app_scoped_user_id/10102599568380936/"}},
 "credentials"=>
  {"token"=>
    "CAAMZCBZB99NS0BAN3JcH3sKSY5udxD2XZCdC1bA0OTugfVUpp7R71REOYtwNHnZCb6ZC9JvrWgmfjWGb3UVGsSYSTjOYlvF1tPstq4KKLPg3193T0kcldZAnNWTMZA6ZCqVpdulwBwqOEyorBGqvrX7fh2dTGAEXi7SYBnW3LEHZAAl4buk4tRDIZC3GZAUspYJh2t3hUuhOMkytQZDZD",
   "expires_at"=>1464284995,
   "expires"=>true},
 "extra"=>
  {"raw_info"=>
    {"id"=>"10102599568380936",
     "name"=>"Bret Doucette",
     "email"=>"doucette.bret@gmail.com",
     "link"=>"https://www.facebook.com/app_scoped_user_id/10102599568380936/"}}}
  }

  it "is valid" do
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user.name = nil
    expect(user).to be_invalid
  end

  it "is invalid without an email" do
    user.email = nil
    expect(user).to be_invalid
  end

  it "must have a proper email format" do
    user.email = "bret"
    expect(user).to be_invalid
  end

  it "must have a proper email format - weird" do
    user.email = "bretDCJADSf9XZZ @ acas d.com"
    expect(user).to be_invalid
  end

  it "creates a user from facebook omniauth" do
    fb_user = User.from_omniauth(auth_hash)
    expect(fb_user.name).to eq("Bret Doucette")
    expect(fb_user.email).to eq("doucette.bret@gmail.com")
  end

  it "sets a new email ONLY if the updated_email is set nil" do
    fb_user = User.from_omniauth(auth_hash)
    fb_user.updated_email = nil
    expect(fb_user.email).to eq("doucette.bret@gmail.com")
  end

  it "does set a new email if the updated_email is set false" do
    fb_user = User.from_omniauth(auth_hash)
    fb_user.updated_email = false
    expect(fb_user.email).to eq("doucette.bret@gmail.com")
  end

  it "does NOT set a new email if the updated_email is set true" do
    fb_user = User.from_omniauth(auth_hash)
    expect(fb_user.email).to eq("doucette.bret@gmail.com")
    fb_user.email = "bad6e@virginia.edu"
    fb_user.update(updated_email: true)
    User.from_omniauth(auth_hash)
    expect(fb_user.email).to eq("bad6e@virginia.edu")
  end
end
