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

  def money_saved
    pack = current_user.habits.cost_a_pack
    avg_cigs = current_user.habits.avg_cig

    cost_per_cig = pack / 20
    entries = current_user.entries
    raise
  end

end
