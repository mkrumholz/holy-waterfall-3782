require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many(:bookings).dependent(:destroy)}
    it {should have_many(:passengers).through(:bookings)}
  end 
  
  describe 'instance methods' do
    before :each do
      @airline_1 = Airline.create!(name: 'Icelandair')
      
      @flight_1 = @airline_1.flights.create!(number: "1234", date: Date.parse('2021-06-01'), departure_city: 'New York', arrival_city: 'Reykjavik')

      @passenger_1 = Passenger.create!(name: 'JJ', age: 33)
      @passenger_2 = Passenger.create!(name: 'Molly', age: 31)

      @booking_1 = Booking.create!(flight_id: @flight_1.id, passenger_id: @passenger_1.id)
    end  

    describe '#airline_name' do
      it 'returns the name of the flight\'s airline' do
        expect(@flight_1.airline_name).to eq @airline_1.name
      end
    end

    describe '#booking_for' do
      it 'returns the id of the booking for given passenger' do
        expect(@flight_1.booking_for(@passenger_1.id)).to eq @booking_1.id
      end
    end
  end
end
