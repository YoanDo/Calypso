# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Winter is coming..."

# SEED OF SPOT IF
if Spot.count < 500
  unless Spot.last.latitude.present?
    Spot.destroy_all

    puts "Spots erased"

    # SEED OF SPOT IF

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
      sleep(0.02)
      puts "#{s.name}"
    end
    puts "you have #{count} spot in your databas"
  end
end

# Erase every thing

puts "Erase everything"

Comment.destroy_all
puts "Comments erased"
Message.destroy_all
puts "Messages erased"
Review.destroy_all
puts "Reviews erased"
Location.destroy_all
puts "Location erased"
Participant.destroy_all
puts "Participants erased"
Trip.destroy_all
puts "Trips erased"
User.destroy_all
puts "Users erased"

puts "let's seed that"

# Users

u1 = User.new

u1.email = "1@calipso.surf"
u1.password = "00000000"
u1.description = "Aloha,
I offer surf guiding Bordeaux
As a local, I know very well about every surf spots in mainland, and also some secret spots.
For my surf guiding service, I can also guide you to places outside (expenses like meals, land transport, accommodation, and tickets will have to be discussed)."
u1.level = "Expert"
u1.location = "Bordeaux"
u1.language = "French"
u1.facebook_picture_url = "http://swilo.imgix.net/profile/0001/01/acd45c005cfb199cdd48bfcb6a6c877703b75a3b.jpeg?w=200&h=200&fit=crop"
u1.first_name = "Kevin"
u1.last_name = "Cimaja"
u1.phone = "0642424242"

u1.save!

puts "User 1 seed : #{u1.email} #{u1.password}"

u2 = User.new

u2.email = "2@calipso.surf"
u2.password = "00000000"
u2.description = "I offer surf guiding sessions from South Vendée to North Vendée based on forecast and tides. We can meet straight at the surf spot or depart from Jard sur mer. We can depart as well from Nantes and surf in Vendée or Bretagne. Distance is not a matter for me when it is all about having fun in the water. Mellow to hollow waves, knee high to double overhead waves, i'll go! See you in the water."
u2.level = "Good"
u2.location = "Bidart"
u2.language = "French"
u2.facebook_picture_url = "http://swilo.imgix.net/profile/0001/01/5a31fbb41c00cbd08269a1f76b5506850c0b4799.jpeg?w=200&h=200&fit=crop"
u2.first_name = "Thomas"
u2.last_name = "Brieux"
u2.phone = "0642424242"

u2.save!

puts "User 2 seed : #{u2.email} #{u2.password}"

u3 = User.new

u3.email = "3@calipso.surf"
u3.password = "00000000"
u3.description = "I'm a french bodyboarder that grew up in central america (Guatemala, Nicaragua, Costa Rica, Mexico and Salvador). I'm living now in Nantes. I'm offering surf guiding services mostly on the French coast but available to travel all around the world. Growing up with surfers, i know their expectations. I like surfing hollow waves, reef and slabs but when the french beach breaks are on fire i'm always keen to go as well. If you want to surf big waves i have no limit (Well 15ft+ would be gnarly which is anyway really rare in France), Whatever the conditions i'll be able to find you the best surf spots, even onshore waves i'll be happy to be in the water. Distances is not a matter to me, i love to wake up early in the morning, driving five hours for a good surf!"
u3.level = "Expert"
u3.location = "Etretat"
u3.language = "French"
u3.facebook_picture_url = "http://swilo.imgix.net/profile/0001/02/701fec270465a0d4946f358839f1a15db9a57782.jpeg?w=200&h=200&fit=crop"
u3.first_name = "Gaspard"
u3.last_name = "Deaujo"
u3.phone = "0642424242"

u3.save!

puts "User 3 seed : #{u3.email} #{u3.password}"

u4 = User.new

u4.email = "4@calipso.surf"
u4.password = "00000000"
u4.description = "Hi,
My name is Alexander, I'm a Quiberon. I've been surfing here for 16 years and my passion for waves always stayed the same.
Bretagne has a good number of various waves to offer: consistent beach breaks, BZH style point breaks and long and hollow reefs.
I can easily adapt to a various range of waves and sizes with a small preference for maneuvers waves.
I love to share this passion with surfers from all over the world. I've been teaching for 8 years and am able to easily adapt to any age, skill level and to your preferences.
Moreover, Popoyo ahs the chance to have a very consistent swell as well as offshore winds all day, offering very good conditions most days."
u4.level = "Expert"
u4.location = "Quiberon"
u4.language = "French"
u4.facebook_picture_url = "http://swilo.imgix.net/profile/0001/01/716322fab2603a2284a6bf094e7b536355efaa65.jpeg?w=200&h=200&fit=crop"
u4.first_name = "Jules"
u4.last_name = "Thiergau"
u4.phone = "0642424242"

u4.save!

puts "User 4 seed : #{u4.email} #{u4.password}"

u5 = User.new

u5.email = "5@calipso.surf"
u5.password = "00000000"
u5.description = "Our team is composed of professional surfers who know the coast of Etrat as nobody else.
The coast has more than ten beaches and many secret spots for surfing.
Surf Camp at Surf Riders exists so you can book accommodation and activities in a package - you can always send us an email and make your own package.
As a complement to surfing we have several activities to enjoy on your vacation such as diving baptism, horse riding, paintball, artisanal fishing - can be booked in advance with us. "
u5.level = "Good"
u5.location = "Etretat"
u5.language = "French"
u5.facebook_picture_url = "http://swilo.imgix.net/profile/0001/01/5cdd0aec42d4e422919407d41abf66fd1f334c62.jpeg?w=200&h=200&fit=crop"
u5.first_name = "Samuel"
u5.last_name = "Pereira"
u5.phone = "0642424242"

u5.save!

puts "User 5 seed : #{u5.email} #{u5.password}"

u6 = User.new

u6.email = "6@calipso.surf"
u6.password = "00000000"
u6.description = "Hi, my name is Joao and I'm a surfer, based in Hendaye (European Best Destination for 2017)
I'm an experienced, former competitor and travelled surfer from French.
I'm also certified surf coach by French surfing federation."
u6.level = "Good"
u6.location = "Hendaye"
u6.language = "French"
u6.facebook_picture_url = "http://swilo.imgix.net/profile/0001/01/f04d64017343950adf629c499b508c97bedb49d9.jpeg?w=200&h=200&fit=crop"
u6.first_name = "Joao"
u6.last_name = "Gomez"
u6.phone = "0642424242"

u6.save!

puts "User 6 seed : #{u6.email} #{u6.password}"

u7 = User.new

u7.email = "7@calipso.surf"
u7.password = "00000000"
u7.description = "Hello,
My name is Dana, I'm a local surfer from guethary.
I started surfing alone when I was 16. I surf every day and I was able to recover my initial level and didn't forget how to get barreled.
I've been teaching surfing in a hendaye Surf Surf School for 3 years, for all type of level and age and for people with autism.
You can count on me to let you discover the different waves of my country, I've been traveling and surfing everywhere in Israel. I also traveled and surfed in Sri Lanka, Australia, Nicaragua, and Salvador where I was able to enjoy a variety of wave and experiences.
You got to strike when the moment is right without thinking Pink Floyd-Animals"
u7.level = "Good"
u7.location = "Hendaye"
u7.language = "French"
u7.facebook_picture_url = "http://swilo.imgix.net/profile/0001/02/d62ad07c582fa6611666e832c0b097840525bb0c.jpeg?w=200&h=200&fit=crop"
u7.first_name = "Dana"
u7.last_name = "Dupont"
u7.phone = "0642424242"

u7.save!

puts "User 7 seed : #{u7.email} #{u7.password}"

u8 = User.new

u8.email = "8@calipso.surf"
u8.password = "00000000"
u8.description = "Hey
Je respecte ton avis tu vois mais en même temps c’est pas le mien donc c’est pas le bon...
Moi le matin, je casse le vent, je fais chier les gens ça me purifie c’est important.
J’te fascine hein ? Allez viens on parle de moi !
Pas de violence, c’est les vacances !
Faux ! Faux ! Complètement faux ! J’ai envie de te dire menteur !"
u8.level = "Good"
u8.location = "Nice"
u8.language = "French"
u8.facebook_picture_url = "http://images.sudouest.fr/2016/01/04/57e100ab66a4bde778c6955a/default/1000/sur-le-tournage-brice-de-nice-3.jpg"
u8.first_name = "Brice"
u8.last_name = "de Nice"
u8.phone = "0642424242"

u8.save!

puts "User 8 seed : #{u8.email} #{u8.password}"

u9 = User.new

u9.email = "9@calipso.surf"
u9.password = "00000000"
u9.description = "A cause, ou plutôt grâce, aux réseaux sociaux, il est facile de connaitre la vie de tout le monde. Photos de maisons de rêve, de corps de rêve, de spots de rêve et le tout en direct. Nos cerveaux sont chaque jour, et souvent dès le réveil, blindés de photos qui font baver et qui nous oblige à comparer notre vie avec celle d’un inconnu vivant à l’autre bout de la planète. Puisque tout à l’air mieux chez l’autre et que l’humain dans sa nature souhaite toujours ce qu’il n’a pas, nous sommes donc mal barrés pour se suffire de notre propre parcelle de terrain et de ce qui nous entoure. Tout quitter pour une autre vie, pour un sport, pour un endroit, mais à quel prix ?"
u9.level = "Expert"
u9.location = "Saint jean de Luz"
u9.language = "French"
u9.facebook_picture_url = "https://i0.wp.com/www.allonsrider.fr/wp-content/uploads/2017/08/surfwaxbox-paysbasque-chloefayollas-2.jpg?resize=759%2C500"
u9.first_name = "Chloe"
u9.last_name = "De saint"
u9.phone = "0642424242"

u9.save!

puts "User 9 seed : #{u9.email} #{u9.password}"

u10 = User.new

u10.email = "10@calipso.surf"
u10.password = "00000000"
u10.description = "Hi everyone,
I'm Alex a local bodyboarder from brest. I've been bodyboarding for 15 years and I've been articulating my life around waves and travel to live my passion.
I've always enjoyed surfing with locals and never had a problem wherever I traveled. That's what I want to share with other surfers when they come to my country.
Puerto Rico offers a wide range of waves and difficulty, suitable for beginners as well as kamikaze!
I've been traveling to many countries along the years: Peru, Indonesia, Hawaii, Nicaragua, Salvador, Cuba, California, Japan, etc. This allowed me to significantly improve my level and being able to surf any type of wave. However, I have a preference for slabs, which are more than common here.
I'll adapt the choice of spot and waves according to your level, your preferences and the conditions of the day.
Please come visit and enjoy Puerto Rican waves, I'll be happy to guide you, advise you and photograph you."
u10.level = "Expert"
u10.location = "La torche"
u10.language = "French"
u10.facebook_picture_url = "https://i0.wp.com/www.allonsrider.fr/wp-content/uploads/2017/08/surfwaxbox-paysbasque-chloefayollas-2.jpg?resize=759%2C500"
u10.first_name = "Alex"
u10.last_name = "Tout"
u10.phone = "0642424242"

u10.save!

puts "User 10 seed : #{u10.email} #{u10.password}"

puts "lets seed Trip"

t1 = Trip.new

t1.title = "Discover Etretat"
t1.starts_at = "Sat, 02 Sep 2017 08:30:00 UTC +00:00"
t1.ends_at = "Sat, 02 Sep 2017 20:30:00 UTC +00:00"
t1.description = "Etretat seems to be perfect saturday. lets go surfing
I have a car.
Weather seems sunny"
t1.nb_participant = "3"
t1.user = u9
t1.status = "going"
t1.category = "Surf"
t1.car = "Zeg"

t1.save!

Location.create(address: "Paris, France", direction: "from", trip: t1)
Location.create(address: "Etretat", direction: "to", trip: t1)

puts "Trip 1 : #{t1.title}"



t2 = Trip.new

t2.title = "Siouville swell"
t2.starts_at = "Sun, 03 Sep 2017 10:15:00 UTC +00:00"
t2.ends_at = "Sun, 03 Sep 2017 20:30:00 UTC +00:00"
t2.description = "Hello tout le monde!
J’organise un petit trip à destination de Siouville en normandie!
Pour le moment les prévisions ont l’air plutot buen. On partirait dimanche matin tôt.
Le spot est accessible, les débutants n’ayez pas peur de prendre la marée :v:"
t2.nb_participant = "1"
t2.user = u7
t2.status = "going"
t2.category = "Surf"
t2.car = "twingo"

t2.save!

Location.create(address: "Versaille, France", direction: "from", trip: t2)
Location.create(address: "Siouville, France", direction: "to", trip: t2)

puts "Trip 2 : #{t2.title}"

p1 = Participant.new
p1.user = u1
p1.trip = t2
p1.status = "accepted"
p1.message = "hey, Can i join the trip ?"
p1.save!
puts "Participant 1 on #{t2.title}"

t3 = Trip.new

t3.title = "Bask Country Discovery"
t3.starts_at = "Mon, 04 Sep 2017 08:30:00 UTC +00:00"
t3.ends_at = "Mon, 04 Sep 2017 20:30:00 UTC +00:00"
t3.description = "4/6 ft in Bidart !
Perfect condition.
Only expert.
I can lend a surfboard. My dog will come with us.
I know a good coffee for the afternoon"
t3.nb_participant = "5"
t3.user = u2
t3.status = "going"
t3.category = "Surf"
t3.car = "Renault Espace"

t3.save!

Location.create(address: "Bordeaux, France", direction: "from", trip: t3)
Location.create(address: "Bidart, France", direction: "to", trip: t3)

puts "Trip 3 : #{t3.title}"

p2 = Participant.new
p2.user = u1
p2.trip = t3
p2.status = "accepted"
p2.message = "swell seems perfect. Can i join ?"
p2.save!

puts "Participant 2 on #{t3.title}"

p3 = Participant.new
p3.user = u8
p3.trip = t3
p3.status = "accepted"
p3.message = "Awesome. I want to surf"
p3.save!

puts "Participant 3 on #{t3.title}"

t4 = Trip.new

t4.title = "Beginners trip"
t4.starts_at = "Sun, 03 Sep 2017 08:30:00 UTC +00:00"
t4.ends_at = "Sun, 03 Sep 2017 20:30:00 UTC +00:00"
t4.description = "Med is in fire.
Come down to the beach and enjoy the ocean with us. We offer top notch equipment and professional service. Only a surfer knows the feeling"
t4.nb_participant = "1"
t4.user = u5
t4.status = "going"
t4.category = "Surf"
t4.car = "Van"

t4.save!

Location.create(address: "matrigues, France", direction: "from", trip: t4)
Location.create(address: "Toulon, France", direction: "to", trip: t4)

puts "Trip 4 : #{t4.title}"

t5 = Trip.new

t5.title = "Med is in fire"
t5.starts_at = "Sun, 03 Sep 2017 08:30:00 UTC +00:00"
t5.ends_at = "Sun, 03 Sep 2017 20:30:00 UTC +00:00"
t5.description = "Hi there ! Join me for an amazing surftrip! I have free spots in my car and will drive the whole way (we’ll split gas and toll). We’ll have a full day of surfing together on the best surf spots of the region (I know the place pretty well :p). Bring some food and drinks too !"
t5.nb_participant = "5"
t5.user = u6
t5.status = "going"
t5.category = "Surf"
t5.car = "Combi Wol"

t5.save!

Location.create(address: "Marseille, France", direction: "from", trip: t5)
Location.create(address: "Toulon, France", direction: "to", trip: t5)

puts "Trip 5 : #{t5.title}"

t6 = Trip.new

t6.title = "Med is in fire again"
t6.starts_at = "Sun, 10 Sep 2017 07:30:00 UTC +00:00"
t6.ends_at = "Sun, 10 Sep 2017 20:30:00 UTC +00:00"
t6.description = "Hi there ! Join me for an amazing surftrip! I have free spots in my car and will drive the whole way (we’ll split gas and toll). We’ll have a full day of surfing together on the best surf spots of the region (I know the place pretty well :p). Bring some food and drinks too !"
t6.nb_participant = "5"
t6.user = u6
t6.status = "going"
t6.category = "Surf"
t6.car = "Combi Wol"

t6.save!

Location.create(address: "Marseille, France", direction: "from", trip: t6)
Location.create(address: "Toulon, France", direction: "to", trip: t6)

puts "Trip 6 : #{t6.title}"

t7 = Trip.new

t7.title = "QuiQuiberon"
t7.starts_at = "Mon, 04 Sep 2017 10:30:00 UTC +00:00"
t7.ends_at = "Mon, 04 Sep 2017 20:30:00 UTC +00:00"
t7.description = "lets go surfing.
I'm a expert surfer. i can give advises during the trip.
My car is pretty big wso you can come with a longboard"
t7.nb_participant = "5"
t7.user = u2
t7.status = "going"
t7.category = "Windsurf"
t7.car = "Kango"

t7.save!

Location.create(address: "Chatou, France", direction: "from", trip: t7)
Location.create(address: "Quiberon, France", direction: "to", trip: t7)

puts "Trip 7 : #{t7.title}"

t8 = Trip.new

t8.title = "BZ in fire"
t8.starts_at = "Sun, 03 Sep 2017 08:30:00 UTC +00:00"
t8.ends_at = "Sun, 03 Sep 2017 20:30:00 UTC +00:00"
t8.description = "Bretagne is one of the best surfing destination in the world for beginners up to pros and you can surf the best wave BZH has to offer.
We provide surf guiding services and surf lessons,with beautiful white sandy beach and uncrowded surf spots with very experienced surf coaching and high-performance surf background"
t8.nb_participant = "2"
t8.user = u2
t8.status = "going"
t8.category = "Surf"
t8.car = "Kango"

t8.save!

Location.create(address: "Levallois, France", direction: "from", trip: t8)
Location.create(address: "La torche, France", direction: "to", trip: t8)

puts "Trip 8 : #{t8.title}"

t9 = Trip.new

t9.title = "Etel"
t9.starts_at = "Tue, 05 Sep 2017 08:30:00 UTC +00:00"
t9.ends_at = "Tue, 05 Sep 2017 20:30:00 UTC +00:00"
t9.description = "Hi,
I'm Cindy a local surfer girl from Nantes.
I love adventure and getting on the search for new surf spots!
I've been surfing for 14 years now and competing for 12. I grew up, learned and trained on a solid and fast beach break which I think is one of the most powerful here in Guatemala.
I have a big preference for point breaks, long rights, and obviously barrels but I can adapt to all type of waves"
t9.nb_participant = "2"
t9.user = u2
t9.status = "going"
t9.category = "Surf"
t9.car = "zeg"

t9.save!

Location.create(address: "Nantes, France", direction: "from", trip: t9)
Location.create(address: "Etel, France", direction: "to", trip: t9)

puts "Trip 9 : #{t9.title}"

t10 = Trip.new

t10.title = "2 days trip"
t10.starts_at = "Sat, 09 Sep 2017 08:30:00 UTC +00:00"
t10.ends_at = "Sun, 10 Sep 2017 20:30:00 UTC +00:00"
t10.description = "Going near Sciotot next week end.
We can sleep in a camping or in the car.
Swell seems to come"
t10.nb_participant = "2"
t10.user = u4
t10.status = "going"
t10.category = "Kitesurf"
t10.car = "zeg"

t10.save!

Location.create(address: "Nanterre, France", direction: "from", trip: t10)
Location.create(address: "Sciotot , France", direction: "to", trip: t10)

puts "Trip 10 : #{t10.title}"

t11 = Trip.new

t11.title = "Vendee one day trip"
t11.starts_at = "Sat, 09 Sep 2017 08:30:00 UTC +00:00"
t11.ends_at = "Sat, 09 Sep 2017 20:30:00 UTC +00:00"
t11.description = "Hi! I've been surfing for 18 years here in Vendee. From the guatemalan surfing early years I have been blessed to know our south coast and it's local comunities."
t11.nb_participant = "2"
t11.user = u3
t11.status = "going"
t11.category = "Surf"
t11.car = "zeg"

t11.save!

Location.create(address: "Nantes, France", direction: "from", trip: t11)
Location.create(address: "Saint Gilles Croix de Vie , France", direction: "to", trip: t11)

puts "Trip 11 : #{t11.title}"

t12 = Trip.new

t12.title = "How is vendee"
t12.starts_at = "Mon, 11 Sep 2017 09:00:00 UTC +00:00"
t12.ends_at = "Mon, 11 Sep 2017 20:30:00 UTC +00:00"
t12.description = "Hi! I've been surfing for 18 years here in Vendee. From the guatemalan surfing early years I have been blessed to know our south coast and it's local comunities."
t12.nb_participant = "2"
t12.user = u1
t12.status = "going"
t12.category = "Surf"
t12.car = "4x4"

t12.save!

Location.create(address: "Bordeaux, France", direction: "from", trip: t12)
Location.create(address: "La Sauzaie, France", direction: "to", trip: t12)

puts "Trip 12 : #{t12.title}"

t13 = Trip.new

t13.title = "3 days trip"
t13.starts_at = "Sat, 09 Sep 2017 06:15:00 UTC +00:00"
t13.ends_at = "Mon, 11 Sep 2017 20:30:00 UTC +00:00"
t13.description = "Hey, i want to go 3 days in vendee. I used to go there when i was child. I learn to surf there. it's pretty awesome"
t13.nb_participant = "3"
t13.user = u1
t13.status = "going"
t13.category = "Surf"
t13.car = "camping car"

t13.save!

Location.create(address: "5e Arrondissement, Paris", direction: "from", trip: t13)
Location.create(address: "Les Sables-D'Olonne, France", direction: "to", trip: t13)

puts "Trip 13 : #{t13.title}"

t14 = Trip.new

t14.title = "Spanish country"
t14.starts_at = "Mon, 11 Sep 2017 05:45:00 UTC +00:00"
t14.ends_at = "Mon, 11 Sep 2017 20:30:00 UTC +00:00"
t14.description = "hey ! I have one day off next monday. Come and join me."
t14.nb_participant = "3"
t14.user = u1
t14.status = "going"
t14.category = "Surf"
t14.car = "camping car"

t14.save!

Location.create(address: "Bordeaux, France", direction: "from", trip: t14)
Location.create(address: "Mundaka, Biscaye, Espagne", direction: "to", trip: t14)

puts "Trip 14 : #{t14.title}"

t15 = Trip.new

t15.title = "Winter is coming"
t15.starts_at = "Mon, 11 Sep 2017 09:30:00 UTC +00:00"
t15.ends_at = "Mon, 11 Sep 2017 20:30:00 UTC +00:00"
t15.description = "Hi there ! Join me for an amazing surftrip! I have free spots in my car and will drive the whole way (we’ll split gas and toll). We’ll have a full day of surfing together on the best surf spots of the region (I know the place pretty well :p). Bring some food and drinks too !"
t15.nb_participant = "3"
t15.user = u8
t15.status = "going"
t15.category = "Kitesurf"
t15.car = "Mercedes"

t15.save!

Location.create(address: "Paris, France", direction: "from", trip: t15)
Location.create(address: "Etretat, France", direction: "to", trip: t15)

puts "Trip 15 : #{t15.title}"

t16 = Trip.new

t16.title = "Swell is coming"
t16.starts_at = "Tue, 12 Sep 2017 07:00:00 UTC +00:00"
t16.ends_at = "Tue, 12 Sep 2017 20:30:00 UTC +00:00"
t16.description = "Join me for a one day trip"
t16.nb_participant = "3"
t16.user = u5
t16.status = "going"
t16.category = "Surf"
t16.car = "Mercedes"

t16.save!

Location.create(address: "Paris, France", direction: "from", trip: t16)
Location.create(address: "Quiberon, France", direction: "to", trip: t16)

puts "Trip 16 : #{t16.title}"

t17 = Trip.new

t17.title = "Siouville on fire sunday"
t17.starts_at = "Sun, 03 Sep 2017 07:30:00 UTC +00:00"
t17.ends_at = "Sun, 03 Sep 2017 20:30:00 UTC +00:00"
t17.description = "Etretat seems to be perfect saturday. lets go surfing
I have a car.
Weather is sunny"
t17.nb_participant = "6"
t17.user = u9
t17.status = "going"
t17.category = "Surf"
t17.car = "Combi Volkswagen"

t17.save!

Location.create(address: "Paris, France", direction: "from", trip: t17)
Location.create(address: "Siouville, France", direction: "to", trip: t17)

puts "Trip 17 : #{t17.title}"

p4 = Participant.new
p4.user = u8
p4.trip = t17
p4.status = "accepted"
p4.message = "Awesome. I want to surf"
p4.save!

puts "Participant 4 on #{t17.title}"

p5 = Participant.new
p5.user = u9
p5.trip = t17
p5.status = "accepted"
p5.message = "Can i join you ?"
p5.save!

puts "Participant 5 on #{t17.title}"

p6 = Participant.new
p6.user = u5
p6.trip = t17
p6.status = "accepted"
p6.message = "Could i come with my Dog ?"
p6.save!

puts "Participant 6 on #{t17.title}"



