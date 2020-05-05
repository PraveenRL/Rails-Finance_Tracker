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
1. **gem 'iex-ruby-client'**
2. Create free acount in IEX cloud
3. Turn on **SANDBOX TESTING**
4. Go to API Tokens and copy PUBLISHABLE
__Refer : git iex ruby client__

```
client = IEX::Api::Client.new(
  publishable_token: 'publishable_token',
  endpoint: 'https://sandbox.iexapis.com/v1'
)
```

### Generate a model  
`rails generate model Stock ticker:string name:string last_price:decimal`
**Rails console**
> `my_stock = Stock.new(name: "Alphabet", ticker: "GOOG", last_price: 1300)`  
> `my_stock.save`  
> `google = Stock.find(1)`

## Create a method as below in stock.rb (model)  
```
class Stock < ApplicationRecord  
    def self.new_lookup(ticker_symbol)  
        client = IEX::Api::Client.new(publishable_token: 'token_from_iex-cloud',  
                                      endpoint: 'https://sandbox.iexapis.com/v1')  
        client.price(ticker_symbol)  
    end  
end
```

and try in rails console as below  
`Stock.new_lookup('GOOG')`

## Secure Credentials
Open config\credentials.yml.enc  
`SET EDITOR=code --wait`  
`rails credentials:edit`

### To access the key 
Open rails console =>
`Rails.application.credentials.aws[:access_key_id]`

### Change and Save credentials  
Remove the aws and paste the follwing  
> iex_client:  
> sandbox_api_key: "iex_original_key"

**Replace __Rails.application.credentials.iex_client[:sandbox_api_key]__ in stock.rb at publishable_token**

#Setup front-end structure for stock lookup

1. *Create a route as __get 'my_portfolio', to: 'users#my_portfolio'*
2. Install **gem "font-awesome-rails"**

```
<%= text_field_tag :stock, params[:stock] %>
  text_field_tag will pass through params as 
  http://localhost:3000/my_portfolio?stock=#
```

# Users and Stocks (Many-To-Many)
1. User model and Stock model, we will work with primary keys for both and use them as foreign keys
2. **user_stocks_controller.rb** controller file
3. **user_stock.rb** model file
4. **user_stocks** table

### Create a resource for Many-To-Many relationship
> rails generate resource UserStock user:references stock:references

# Friendship mode
1. `rails g model Friendship user:references`
2. Add **t.references :friend, references: :users, foreign_key: { to_table: :users }** inside create_friendship   migration file
3. Add **belongs_to :friend, class_name: 'User'** in friendship.rb file
4. Add  
  **has_many :friendships**  
  **has_many :friends, through: :friendships**  
  to user.rb

```
rails console >
user = User.first
user_2 = User.last
user.friends << user_2
```