# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'faker'

puts 'Detroying all previous users...'
User.destroy_all
puts 'Detroying all previous check_ins...'
Check_in.destroy_all
puts 'Detroying all previous reviews...'
Review.destroy_all
puts 'Detroying all previous snow reports...'
Snow_report.destroy_all
puts 'Detroying all previous ski reports...'
Ski_resort.destroy_all

puts 'Creating now a new db!'

# creating skii resorts
50.times do
  Ski_resort.create!(
    {
      name: Faker::Restaurant.name,
      location: Faker::Address.full_address,
      description: Faker::Restaurant.description,
      average_rating: rand(0..5),
      url: Faker::Internet.url,
      latitude: Faker::Address.latitude,
      longitud: Faker::Address.longitude,
    }
  )
end


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
    check_in = Check_in.new({ checked_out_at: Faker::Date.between(from: 1095.days.ago, to: Date.today) })
    check_in.user = user
    check_in.ski_resort = Ski_resort.all.sample
    check_in.save!

    review = Review.new(
      {
        comment: Faker::Restaurant.review,
        waiting_rating: rand(0..5)
      }
    )
    review.check_in = check_in
    review.save!

    snow_report = Snow_report.new({ rating: rand(0..5) })
    snow_report.check_in = check_in
    snow_report.save!
  end
end


# assigning a resort as default to the first user, no review or snow report for this default resort yet
check_in_default = Check_in.create!({ checked_out_at: nil })
check_in_default.user = User.first
check_in_default.ski_resort = Ski_resort.all.sample
check_in_default.save!


puts 'Done! :)'
