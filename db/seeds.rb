# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "let's go"

Spot.destroy_all

puts "spots erased"

# url = 'https://services.surfline.com/kbyg/mapview?south=-90&west=0&north=90&east=360'
# url = 'https://services.surfline.com/kbyg/mapview?south=35.38904996691167&west=-25.927734375000004&north=55.27911529201564&east=28.564453125000004'
file = File.read('db/seeds/spots.json')

# surflinejson = open(url).read
js = JSON.parse(file)

count = 0

js['data']['spots'].each do |spot|
  s = Spot.new
  s.name = spot["name"]
  s.latitude = spot["lat"]
  s.longitude = spot["lon"]
  s.id_surfline = spot["_id"]
  s.save
  count += 1
end

puts "you have #{count} spot in your databas"

