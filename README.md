## Too Many Miles - Set Up Information

In order to get this repo working follow these steps:

Clone Repo

    $ cd credit_cards
    $ bundle
    $ rake db:create
    $ rake db:migrate
    $ rake db:seed
    $ rails s

Navigate to http://localhost:3000/

**DO NOT** run the follwoing rake commands ever on development:

    $ rake update_cards
