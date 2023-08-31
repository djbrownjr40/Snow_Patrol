# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'faker'
require 'csv'
require 'open-uri'
require 'json'
require 'net/http'

# SEED ONCE WITH THE RESORTS UNCOMENTED AND THEN COMMENT THEM OUT
# there's no point on destroying and recreating them cause they're going to stay the same

ski_resorts = 'db/ski_resorts.csv'

puts 'Detroying all previous ski reports...'
SkiResort.destroy_all

CSV.foreach(ski_resorts, headers: :first_row, header_converters: :symbol) do |row|
  puts 'creating ski resort'
  ski_resort = SkiResort.create!(
    {
      name: row[:resort_name],
      location: "#{row[:town]}, #{row[:prefecture]}",
      description: "#{row[:name_ja]}, #{row[:address_ja]}",
      url: "https://www.snowjapan.com/japan-ski-resorts" + row[:url_path],
      latitude: row[:latitude],
      longitude: row[:longitude],
      height: rand(150.0..350.0),
      length: rand(15.0..35.0),
      temp: rand(-15.0..3.0),
      courses: {
        easy: rand(0..4),
        intermediate: rand(0..4),
        advanced: rand(0..4)
      }
    }
  )
  dashed_name = ski_resort.name.gsub(" ", "-")
  url = "https://www.snowjapan.com/rest-api/skiarea/#{dashed_name}"
  uri = URI(url)
  body = {}
  headers = {"accept": "application/json, text/plain, */*", "accept-language": "en-US,en;q=0.5"}
  response = Net::HTTP.post(uri, body.to_json, headers)
  resort = JSON.parse(response.body)
  id = resort['Id']

  photo_url = "https://www.snowjapan.com/rest-api/skiarea/photos/1"
  photo_uri = URI(photo_url)
  photo_body = {"resortid": id}
  photo_headers = {
    "accept": "application/json, text/plain, */*",
    "content-type": "application/json;charset=UTF-8"
  }
  photo_response = Net::HTTP.post(photo_uri, photo_body.to_json, photo_headers)
  parsed_photos = JSON.parse(photo_response.body)
  p parsed_photos[0]
  parsed_photo = parsed_photos[0]
  if parsed_photo

    parsed_photo = parsed_photos[0]
    parsed_photo_name = parsed_photo["PhotoFileName"].gsub(' ', '%20')
    parsed_photo_user = parsed_photo["CreatedByUserName"].gsub(' ', '%20')

    photo_file_url = "https://www.snowjapan.com/photo-galleries/#{parsed_photo_user}/#{parsed_photo_name}"
    photo_file = URI.open(photo_file_url)

    ski_resort.photo.attach(io: photo_file, filename: "resort.png", content_type: "image/png")
  end
end
puts 'ski resorts made'

puts 'Detroying all previous users...'
User.destroy_all

puts 'Creating now a new db!'
user_no = 0

# creating 10 users, each of them has been to 5 resorts, left 1 review and 1 snow report
# none of them have a default resort assigned
100.times do
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

  50.times do
    check_in = CheckIn.new({ checked_out_at: Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all) })
    check_in.user = user
    check_in.ski_resort = SkiResort.all.sample
    check_in.save!

    review = Review.new(
      {
        comment: Faker::Lorem.sentences(number: 1),
        lift_wait_rating: rand(1..5),
        price_rating: rand(1..5),
        crowd_rating: rand(1..5),
        food_rating: rand(1..5),
        location_rating: rand(1..5)
      }
    )
    review.check_in = check_in
    review.save!

    snow_report = SnowReport.new({ rating: rand(1..5) })
    snow_report.check_in = check_in
    snow_report.created_at = Faker::Time.between_dates(from: Date.today, to: Date.today, period: :day)
    snow_report.save!
  end
  user_no += 1
  puts "user#{user_no} made"
end


# assigning a resort as default to the first user, no review or snow report for this default resort yet
check_in_default = CheckIn.new({ checked_out_at: nil })
check_in_default.user = User.first
check_in_default.ski_resort = SkiResort.all.sample
check_in_default.save!

puts SkiResort.first.inspect
puts 'Done! :)'
