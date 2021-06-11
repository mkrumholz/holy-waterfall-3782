class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def qualified_passengers
    passengers.select('passengers.*, count(distinct flights.id) as flight_count')
    .where('passengers.age >= ?', 18)
    .group('passengers.id')
    .order('flight_count desc')
    .distinct
  end
end
