ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'support/features'

require 'sidekiq/testing'
Sidekiq::Testing.fake!

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
                  "provider"=>"facebook",
                   "uid"=>"10102534528384326",
                   "info"=>
                  {"email" => "bretisamazing@me.com",
                   "name"=>"Bret Doucette",
                   "image"=>"http://graph.facebook.com/10102534528384326/picture",
                   "urls"=>{"Facebook"=>"https://www.facebook.com/app_scoped_user_id/10102534528384326/"}},
                  "credentials"=>
                  {"token"=>
                    "CAAMeGgv1zny1a02i0vfZBPZBt649DwYGbYk7PRB7Cw8LnZBYNFZAliCNlD3dZBhUZCQPt6SuOPBnZCZA0DBCJSFNAAXAA7qbAcZD",
                    "expires_at"=>1463523177,
                    "expires"=>true},
                  "extra"=>
                    {"raw_info"=>
                    {"id"=>"10102534528384326",
                     "name"=>"Bret Doucette",
                     "email"=> "bretisamazing@me.com",
                     "link"=>"https://www.facebook.com/app_scoped_user_id/10102534528384326/"}}})

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.mock_with :mocha

  config.infer_spec_type_from_file_location!
end
