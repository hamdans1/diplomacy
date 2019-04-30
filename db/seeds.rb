require 'random_data'

50.times do
  Campaign.create!(
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
puts "#{Campaign.count} campaigns created"
puts "#{Game.count} games created"
