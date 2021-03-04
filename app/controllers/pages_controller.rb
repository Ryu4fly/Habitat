class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def profile
    @habits = current_user.habit
  end

  def game
    @balance = current_user.balance
  end

end
