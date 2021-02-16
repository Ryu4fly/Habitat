# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying all data 📀 ..."

User.destroy_all

puts "Generating new users..."
10.times do
  user = User.new
  user.email = Faker::Internet.email #=> "kirsten.greenholt@corkeryfisher.info"
  user.password = '123456'
  user.username = Faker::Name.unique.name # This will return a unique name every time it is called
  user.avg_cig = 8
  user.days_smoke_free = rand 30
  user.cost_a_pack = rand 450..510
  user.save
  puts "#{user.id} - #{user.email} created.."
end

20.times do
  entry = Entry.new
  date = DateTime.new(rand(1985..1997), rand(1..12), rand(1..24), rand(1..12), rand(1..35), rand(1..45))
  entry.date = date
  entry.feeling = Entry::FEELINGS.sample
  entry.user = User.all.sample
  entry.craving = rand(1..10)
  entry.save
  puts "New entry: #{entry.date}, feeling - #{entry.feeling}, craving - #{entry.craving}"
end


puts "All users saved"
