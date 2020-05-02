* -> cmd

# Finance Tracker app

## Athentication System ---------------------

1. Add | gem 'devise' | in Gemfile
2. rails generate devise:install *

# Create User with devise:

> rails generate devise User *  
> paste | before_action :authenticate_user! | inside application_controller.rb
> paste 
  <p class="notice"> <%= notice %> </p>
  <p class="alert"> <%= alert %> </p>
  inside body of application.html.erb

<!-- Now the signup and login page functionality automatically created -->
