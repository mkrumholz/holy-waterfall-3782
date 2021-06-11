class Flight < ApplicationRecord
  belongs_to :airline
  has_many :bookings
  has_many :passengers, through: :bookings
end
