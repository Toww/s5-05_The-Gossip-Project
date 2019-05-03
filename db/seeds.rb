# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

# Pour garder un nombre cohérent de User / Cities etc... avec les nouveaux migrates et seeds
# pendant les phases de test, on destroy toutes les entrées des tables à chaque début de seed

User.destroy_all
City.destroy_all
Gossip.destroy_all

10.times do 
	
	city = City.create!(
		name: Faker::Address.city,
		zip_code: Faker::Base.regexify(/[0-8][0-9][0-9]{3}/)
		)
	puts "City added"

	user = User.create!(
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		description: Faker::Lorem.paragraph,
		email: Faker::Internet.email,
		age: rand(18..99), # random pour avoir un age au hasard entre 18 et 99 ans
		city: city,
		password: "dumdum" # On spécifie un même mot de passe à tous les faux users pour faire des tests 
		)
	puts "User added"

	tag = Tag.create!(
		title: Faker::Lorem.word
		)
	puts "Tag added"

	2.times do
		@gossip = Gossip.create!(
			title: Faker::Lorem.paragraph_by_chars(12, false),
			content: Faker::Lorem.paragraph,
			user: user
			)
		puts "Gossip added"
	end

	@number_comments = rand(1..8)

	@number_comments.times do
		comment = Comment.create!(
				content: Faker::Movie.quote,
				user: user,
				gossip: @gossip
			)
	end

end

# Ajout d'un utilisateur anonymous
User.create(first_name: "Michel", last_name: "Anonymous", description: "Lorem ipsum dolor sit amet quatorem peras exarari nerulam", email: "michel@anonymous.com", age: 52, city: City.last)
puts "User anonymous bien ajouté!"