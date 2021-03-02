require File.dirname(__FILE__) + '/fake_user_names'

puts "Destroying all data 📀 ..."
Win.destroy_all
Loss.destroy_all
Bet.destroy_all
Lane.destroy_all
Habit.destroy_all
Entry.destroy_all
Race.destroy_all
User.destroy_all

puts "Generating new users..."
30.times do
  user = User.new
  user.email = Faker::Internet.email #=> "kirsten.greenholt@corkeryfisher.info"
  user.password = '123456'
  user.username = random_username
  habit = Habit.new
  habit.avg_cig = rand(1..200)
  habit.cost_a_pack = rand(1.00..20.00).round(2)
  user.habit = habit
  user.save
  puts "new user ✨#{user.id} - #{user.email} \n habit 👉 #{user.habit.avg_cig} cigs a day at #{user.habit.cost_a_pack}$ per pack."
end

ryugi = User.new
ryugi.email = 'ryugi@ryugi.edu'
ryugi.password = '123456'
ryugi.username = 'ryugi1973'
ryugishabit = Habit.new
ryugishabit.avg_cig = rand(1..200)
ryugishabit.cost_a_pack = rand(1.00..20.00).round(2)
ryugi.habit = ryugishabit
ryugi.save


def days_in_month(month)
  if [1,3,5, 7, 8, 10, 12].include?(month)
    return rand(1..31)
  elsif [2, 4, 6, 9, 11].include?(month)
    return rand(1..30)
  elsif month == 2
    return rand(1..28)
  else
    puts "ERROR creating race time 😭"
    return false
  end
end

1600.times do
  entry = Entry.new
  year = Time.now.year
  date = DateTime.new(year, rand(1..Time.now.month), rand(1..27), rand(1..12), rand(1..35), rand(1..45))
  entry.date = date
  entry.feeling = Entry::FEELINGS.sample
  entry.context = Entry::CONTEXT.sample
  entry.user = User.all.sample
  entry.craving = rand(1..10)
  entry.cig_smoked = rand(6..12)
  entry.save
  puts "New entry: #{entry.date}, feeling - #{entry.feeling}, craving - #{entry.craving}, cig smoked: #{entry.cig_smoked}"
end

def add_losses_and_wins_to_old_races(race)
  if race.end_time < Time.now
    placings = []
    winner = race.lanes.sample.user
    win = Win.new
    win.user = winner
    win.race = race
    win.save
    race.lanes.each do |lane|
      unless lane.user == winner
        loss = Loss.new
        loss.user = lane.user
        loss.race = race
        placing = rand( 2..race.lanes.length)
        while placings.include?(placing)
          placing = rand( 2..race.lanes.length)
        end
        placings << placing
        loss.placing = placing
        loss.save
      end
    end
  elsif Time.now < race.end_time && Time.now > race.start_time
    # puts "THIS RACE IS ONGOING: #{race}"
  else
    # puts "This race hasn't started yet: #{race}"
  end
end

def add_bets_to_lane(lane)
  used_users = []
  rand(0..15).times do
    user = User.find(User.pluck(:id).shuffle.first)
    while used_users.include?(user) do
      user = User.find(User.pluck(:id).shuffle.first)
    end
    used_users << user
    bet = Bet.new
    bet.user = user
    bet.lane = lane
    bet.amount = rand(1..1000)
    bet.save
  end
end

def add_racers_to_race(race)
  used_users = []
  rand(1..5).times do
    lane = Lane.new
    user = User.find(User.pluck(:id).shuffle.first)
    while used_users.include?(user) do
      user = User.find(User.pluck(:id).shuffle.first)
    end
    used_users << user
    lane.user = user
    lane.race = race
    lane.save
    add_bets_to_lane(lane)
  end
end

120.times do
  race = Race.new
  race.duration = rand(5..31)
  race.public = [true, false].sample
  year = Time.now.year
  month = Time.now.month
  month = Time.now.month - 1 if rand(0..3) == 0
  month = Time.now.month + 1 if rand(0..4) == 0
  day = days_in_month(month)
  race.start_time = Time.new(year, month, day )
  race.end_time = Time.at( race.start_time + race.duration.days )
  race.save
  add_racers_to_race(race)
  add_losses_and_wins_to_old_races(race)
  puts "New race created 🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁"
  puts "Start time: #{race.start_time}"
  puts "Duration: #{race.duration} days"
  race.lanes.all.each_with_index do |lane, index|
    puts "Lane ##{index}: #{lane.user.username}"
    puts "    Bets: 👇💰💰💰💰"
    lane.bets.all.each do |bet|
      puts "        Gambler name: #{bet.user.username}"
      puts "        Bet amount: $#{bet.amount}"
    end
  end
  if race.losses.length > 0
    puts "The results for this race are in 🏆🏆🏆 "
    puts "The champion is... #{race.win.user.username}"
    losers = Array.new
    race.losses.each do |loss|
      losers[loss.placing] = loss.user.username
    end
    losers.each_with_index do |loser, index|
      puts "##{index}: #{loser}" if index > 1
    end
  end
end

