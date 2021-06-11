class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def qualified_passengers
    passengers.where('passengers.age >= ?', 18).distinct
  end
end
