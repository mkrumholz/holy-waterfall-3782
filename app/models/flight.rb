class Flight < ApplicationRecord
  belongs_to :airline
  has_many :bookings, dependent: :destroy
  has_many :passengers, through: :bookings

  def airline_name
    airline.name
  end

  def booking_for(passenger_id)
    passenger = Passenger.find(passenger_id)
    booking = bookings.where(passenger: passenger)
    if booking.present?
      booking.pluck(:id)[0]
    end
  end
end
