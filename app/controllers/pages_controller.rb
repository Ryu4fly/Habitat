class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def profile
    @habits = current_user.habit

    pack = current_user.habit.cost_a_pack
    avg_cigs = current_user.habit.avg_cig

    cost_per_cig = pack / 20
    avg_cost = cost_per_cig * avg_cigs
    entries = current_user.entries.order(date: :asc)
    daily_cigs = reduce_same_date_entries(entries)
    days = (entries.first.date..Date.today)

    days.each do |day| 
      puts day 
    end

    # money_saved = daily_cigs.map do |entry|
    #   money = 0
      
    # end
    raise
  end

  def game
    @balance = current_user.balance
  end
end
