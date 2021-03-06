require 'random_data'
require 'faker'

50.times do
  User.create!(
    name: Faker::TvShows::GameOfThrones.character,
    email: "#{Faker::TvShows::GameOfThrones.character}@#{Faker::University.name}.#{Faker::University.suffix}",
    password: "helloworld"
  )
end

admin = User.create!(
  name: 'Admin User',
  email: 'admin@diplo.com',
  password: 'helloworld',
  role: 'admin'
)

member = User.create!(
  name: 'Member User',
  email: 'member@diplo.com',
  password: 'helloworld'
)

users = User.all

15.times do
  Group.create!(
    name: "#{Faker::TvShows::GameOfThrones.unique.house} Diplomacy Group",
    description: Faker::TvShows::GameOfThrones.quote
  )
end

groups = Group.all

50.times do
  Campaign.create!(
    user: users.sample,
    group: groups.sample,
    title: "#{RandomData.random_year} Campaign",
    scoring: RandomData.random_scoring
  )
end

campaigns = Campaign.all

100.times do
  Game.create!(
    user: users.sample,
    campaign: campaigns.sample,
    title: "#{Faker::TvShows::GameOfThrones.city} battle #{rand(0..6)}",
    scoring: RandomData.random_scoring,
    map: Faker::Nation.nationality,
    style: RandomData.random_style
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Group.count} groups created"
puts "#{Campaign.count} campaigns created"
puts "#{Game.count} games created"
