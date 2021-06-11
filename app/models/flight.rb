class Flight < ApplicationRecord
  belongs_to :airline
  has_many :bookings, dependent: :destroy
  has_many :passengers, through: :bookings

  def airline_name
    airline.name
  end

  def booking_for(passenger_id)
    bookings.where(passenger: passenger_id).pluck(:id)[0]
  end
end
