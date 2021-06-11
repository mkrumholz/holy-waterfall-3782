# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Passenger.destroy_all
Flight.destroy_all
Airline.destroy_all

airline_1 = Airline.create!(name: 'Icelandair')
airline_2 = Airline.create!(name: 'Korean Air')

# flights for airline 1
flight_1 = airline_1.flights.create!(number: "1234", date: Date.parse('2021-06-01'), departure_city: 'New York', arrival_city: 'Reykjavik')
flight_2 = airline_1.flights.create!(number: "1345", date: Date.parse('2021-06-07'), departure_city: 'Reykjavik', arrival_city: 'Paris')

# flights for airline 2
flight_3 = airline_2.flights.create!(number: "2234", date: Date.parse('2021-06-01'), departure_city: 'Houston', arrival_city: 'Los Angeles')
flight_4 = airline_2.flights.create!(number: "2345", date: Date.parse('2021-06-07'), departure_city: 'Los Angeles', arrival_city: 'Seoul')

# passengers 1 & 2 are on flight 1
passenger_1 = flight_1.passengers.create!(name: 'JJ', age: 33)
passenger_2 = flight_1.passengers.create!(name: 'Molly', age: 31)

# passengers 3 & 4 are on flight 2
passenger_3 = flight_2.passengers.create!(name: 'Dan', age: 12)
passenger_4 = flight_2.passengers.create!(name: 'Joanna', age: 32)

# passenger 5 only has a booking on airline 2
passenger_5 = flight_4.passengers.create!(name: 'Ophelia', age: 47)

# passengers 1 & 3 are on flight 3
flight_3.passengers << passenger_1
flight_3.passengers << passenger_3

# passengers 2 & 4 are on flight 4
flight_4.passengers << passenger_2
flight_4.passengers << passenger_4
