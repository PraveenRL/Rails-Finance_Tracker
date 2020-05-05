class UsersController < ApplicationController

  def my_portfolio
    @tracked_stocks = current_user.stocks #helper from devise, refer in gem devise
  end

  def my_friends
    @friends = current_user.friends
  end

end
