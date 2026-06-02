# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

puts "🧹 Nettoyage de la base..."

Report.destroy_all
Participation.destroy_all
Permanence.destroy_all
Profile.destroy_all
User.destroy_all
Location.destroy_all

puts "📍 Création des lieux..."

locations = [
  {
    name: "CHU de Nantes",
    address: "5 allée de l'Île Gloriette, Nantes",
    latitude: 47.2109,
    longitude: -1.5536
  },
  {
    name: "Hôpital Saint-Jacques",
    address: "85 rue Saint-Jacques, Nantes",
    latitude: 47.1963,
    longitude: -1.5328
  },
  {
    name: "Hôpital Nord Laennec",
    address: "Boulevard Jacques Monod, Saint-Herblain",
    latitude: 47.2448,
    longitude: -1.6408
  },
  {
    name: "EHPAD Le Bois Hercé",
    address: "Nantes",
    latitude: 47.2270,
    longitude: -1.5600
  },
  {
    name: "EHPAD Les Jardins de l'Erdre",
    address: "Nantes",
    latitude: 47.2450,
    longitude: -1.5300
  },
  {
    name: "EHPAD Notre-Dame du Chêne",
    address: "Orvault",
    latitude: 47.2700,
    longitude: -1.6200
  }
].map do |attrs|
  Location.create!(attrs)
end

puts "👥 Création des bénévoles..."

roles = (
  ["benevole en integration"] * 4 +
  ["benevole en formation"] * 4 +
  ["benevole confirmé"] * 5 +
  ["benevole référent"] * 2
).shuffle

users = []

# Compte de démonstration
demo_user = User.create!(
  email: "demo@blousesroses.fr",
  password: "password123"
)

Profile.create!(
  user: demo_user,
  first_name: "Marie",
  last_name: "Dupont",
  role: "benevole référent",
  phone_number: "0612345678",
  address: "Nantes"
)

users << demo_user

15.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  user = User.create!(
    email: "benevole#{i + 1}@blousesroses.fr",
    password: "password123"
  )

  Profile.create!(
    user: user,
    first_name: first_name,
    last_name: last_name,
    role: roles.sample,
    phone_number: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.street_address
  )

  users << user
end

puts "📅 Création des permanences..."

services = [
  "Pédiatrie",
  "EHPAD",
  "Hôpital"
]

week_days = [
  "Lundi",
  "Mardi",
  "Mercredi",
  "Jeudi",
  "Vendredi"
]

permanences = []

20.times do
  permanences << Permanence.create!(
    user: users.sample,
    location: locations.sample,
    service: services.sample,
    week_day: week_days.sample,
    start_time: [9, 10, 14].sample,
    end_time: [12, 13, 17].sample,
    formation: [true, false, false].sample,
    year: 2026
  )
end

puts "🙋 Création des participations..."

80.times do
  Participation.create!(
    user: users.sample,
    permanence: permanences.sample,
    week_number: rand(1..52),
    substitute: [true, false, false, false].sample
  )
end

puts "📝 Création des rapports..."

comments = [
  "Animation lecture très appréciée des enfants.",
  "Bon accueil de l'équipe soignante et forte participation.",
  "Après-midi jeux de société avec plusieurs résidents.",
  "Temps d'échange chaleureux avec les familles.",
  "Atelier créatif particulièrement réussi.",
  "Visite très positive dans le service.",
  "Les patients ont participé avec enthousiasme.",
  "Très belle dynamique de groupe pendant l'activité.",
  "Moment convivial autour de chansons et discussions.",
  "Animation calme et appréciée par les résidents."
]

30.times do
  Report.create!(
    permanence: permanences.sample,
    week_number: rand(1..52),
    patients_number: rand(3..25),
    comment: comments.sample
  )
end

puts ""
puts "✅ Seed terminé !"
puts "Utilisateurs : #{User.count}"
puts "Profils : #{Profile.count}"
puts "Lieux : #{Location.count}"
puts "Permanences : #{Permanence.count}"
puts "Participations : #{Participation.count}"
puts "Rapports : #{Report.count}"
puts ""
puts "Compte de démonstration :"
puts "Email : demo@blousesroses.fr"
puts "Mot de passe : password123"
