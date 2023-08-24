# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'faker'
require 'csv'

# SEED ONCE WITH THE RESORTS UNCOMENTED AND THEN COMMENT THEM OUT
# there's no point on destroying and recreating them cause they're going to stay the same

ski_resorts = 'db/ski_resorts.csv'

puts 'Detroying all previous ski reports...'
SkiResort.destroy_all

CSV.foreach(ski_resorts, headers: :first_row, header_converters: :symbol) do |row|
  SkiResort.create!(
    {
      name: row[:resort_name],
      location: "#{row[:town]}, #{row[:prefecture]}",
      description: "#{row[:name_ja]}, #{row[:address_ja]}",
      url: row[:url_path],
      latitude: row[:latitude],
      longitude: row[:longitude],
      height: rand(150.0..350.0),
      length: rand(15.0..35.0),
      temp: rand(-15.0..3.0),
      features: {
        restaurant: [true, false].sample,
        restroom: [true, false].sample,
        looker_room: [true, false].sample,
        rental_wear: [true, false].sample,
        shower_room: [true, false].sample,
        english_friendly: [true, false].sample,
        kids_friendly:[true, false].sample
      }
    }
  )
end
puts 'skii resorts made'

puts 'Detroying all previous users...'
User.destroy_all
puts 'Detroying all previous check_ins...'
CheckIn.destroy_all
puts 'Detroying all previous reviews...'
Review.destroy_all
puts 'Detroying all previous snow reports...'
SnowReport.destroy_all

puts 'Creating now a new db!'

# creating 10 users, each of them has been to 5 resorts, left 1 review and 1 snow report
# none of them have a default resort assigned
10.times do
  user = User.create!(
    {
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      username: Faker::Internet.username,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      gender: Faker::Gender.type,
      age: rand(18..100)
    }
  )

  5.times do
    check_in = CheckIn.new({ checked_out_at: Faker::Date.between(from: 1095.days.ago, to: Date.today) })
    check_in.user = user
    check_in.ski_resort = SkiResort.all.sample
    check_in.save!

    review = Review.new(
      {
        comment: Faker::Lorem.sentences(number: 1),
        lift_wait_rating: rand(0..5),
        price_rating: rand(0..5),
        crowd_rating: rand(0..5),
        food_rating: rand(0..5),
        location_rating: rand(0..5)
      }
      )
      review.check_in = check_in
      review.save!

      snow_report = SnowReport.new({ rating: rand(0..5) })
      snow_report.check_in = check_in
      snow_report.save!
    end
  puts 'user made'
end


# assigning a resort as default to the first user, no review or snow report for this default resort yet
check_in_default = CheckIn.new({ checked_out_at: nil })
check_in_default.user = User.first
check_in_default.ski_resort = SkiResort.all.sample
check_in_default.save!
puts 'gave 1st user a default'


puts 'Done! :)'
