class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def profile
    entries = current_user.entries.order(date: :asc)
    daily_cigs = reduce_same_date_entries(entries)
    days = (entries.first.date..Date.today).to_a
    @counters = calculate_money_and_cigs(daily_cigs, days)

    @user_balance = current_user.balance
  end

  def game
    @balance = current_user.balance
  end

  private

  def calculate_money_and_cigs(reduced_entries, days)
    total_money = 0
    total_cigs =  0
    days.each do |day|
      daily_results = entry_date_match(reduced_entries, day)
      total_money += daily_results[:money]
      total_cigs += daily_results[:cigs]
    end
    {
      total_money: total_money,
      total_cigs: total_cigs
    }
  end

  def entry_date_match(reduced_entries, date)
    avg_cigs = current_user.habit.avg_cig
    cost_per_cig = current_user.habit.cost_a_pack / 20
    money = 0
    cigs = 0
    reduced_entries.each do |entry|
      if entry[0] == date.to_s
        if entry[1] < avg_cigs
          saved = (avg_cigs - entry[1]) * cost_per_cig
          not_smoked = avg_cigs - entry[1]
        else
          saved = avg_cigs * cost_per_cig
          not_smoked = avg_cigs
        end
        money += saved
        cigs += not_smoked
      end
    end
    {
      money: money,
      cigs: cigs
    }
  end
end
