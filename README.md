## Too Many Miles - Set Up Information

#### In order to get this repo working follow these steps:

##### Note you must have access to Heroku:

    Clone Repo
    $ cd credit_cards
    $ bundle
    $ heroku pg:pull DATABASE_URL creditcards_development
    $ rails s puma
    Navigate to http://localhost:3000/

#### To Run the Tests

    $ rake db:create RAILS_ENV=test
    $ rspec

**DO NOT** run the follwoing rake commands ever on development:

    $ rake update_cards



