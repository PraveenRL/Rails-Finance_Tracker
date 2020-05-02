# Finance Tracker app

## Athentication System ---------------------

1. Add | gem 'devise' | in Gemfile
2. rails generate devise:install $

# Create User with devise:

> `rails generate devise User`  
  paste | before_action :authenticate_user! | inside application_controller.rb
  paste 
  <p class="notice"> <%= notice %> </p>
  <p class="alert"> <%= alert %> </p>
  inside body of application.html.erb

<!-- Now the signup and login page functionality automatically created -->
# Add bootstrap 4
> `yarn add bootstrap@4.4.1 jquery@3.4.1 popper.js`  
## Make the config/webpack/environment.js file as follows:

> const { environment } = require('@rails/webpacker')  
> const webpack = require("webpack")  
> 
> environment.plugins.append("Provide", new webpack.ProvidePlugin({  
>     $: 'jquery',  
>    jQuery: 'jquery',  
>     Popper: ['popper.js', 'default']  
> }))  
> 
> module.exports = environment

## Add | import 'bootstrap' | inside app\javascript\packs\application.js  
Go to app/assets/stylesheets/application.css and add the following line above the require_tree 

> *= require bootstrap

So it looks like below:
> *= require bootstrap
> *= require_tree .
> *= require_self

## Create a file as custum_style.scss inside app\assets\stylesheets\ and paste this to modify class  
@import 'bootstrap/dist/css/bootstrap';

# Add Style using Devise
## Refer `devise bootstrap views`

1. Add `gem 'devise-bootstrap-views', '~> 1.0' ` inside Gemfile and bundle install
2. For Generate views `rails generate devise:views:bootstrap_templates`

# Get API (Stock)
1. Create free acount in IEX cloud
1. Turn on **SANDBOX TESTING**
3. Go to API Tokens and copy PUBLISHABLE

```
client = IEX::Api::Client.new(
  publishable_token: 'publishable_token',
  endpoint: 'https://sandbox.iexapis.com/v1'
)
```