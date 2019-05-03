require 'random_data'

15.times do
  Group.create!(
    name: RandomData.random_sentence,
    description: RandomData.random_sentence
  )
end

groups = Group.all

50.times do
  Campaign.create!(
    group: groups.sample,
    title: RandomData.random_sentence,
    scoring: RandomData.random_sentence
  )
end

campaigns = Campaign.all

100.times do
  Game.create!(
    campaign: campaigns.sample,
    title: RandomData.random_sentence,
    scoring: RandomData.random_sentence,
    map: RandomData.random_sentence,
    style: RandomData.random_sentence
  )
end

puts "Seed finished"
puts "#{Group.count} groups created"
puts "#{Campaign.count} campaigns created"
puts "#{Game.count} games created"
