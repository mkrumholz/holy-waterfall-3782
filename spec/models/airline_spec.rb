require 'rails_helper'

RSpec.describe Airline, type: :model do
  it {should have_many :flights}
  it {should have_many(:passengers).through(:flights)}

  describe 'instance methods' do
    before :each do
      @airline_1 = Airline.create!(name: 'Icelandair')
      @airline_2 = Airline.create!(name: 'Korean Air')
  
      # flights for airline 1
      @flight_1 = @airline_1.flights.create!(number: "1234", date: Date.parse('2021-06-01'), departure_city: 'New York', arrival_city: 'Reykjavik')
      @flight_2 = @airline_1.flights.create!(number: "1345", date: Date.parse('2021-06-07'), departure_city: 'Reykjavik', arrival_city: 'Paris')
  
      # flights for airline 2
      @flight_3 = @airline_2.flights.create!(number: "2234", date: Date.parse('2021-06-01'), departure_city: 'Houston', arrival_city: 'Los Angeles')
      @flight_4 = @airline_2.flights.create!(number: "2345", date: Date.parse('2021-06-07'), departure_city: 'Los Angeles', arrival_city: 'Seoul')
  
      # passengers 1, 2, & 3 are on flights for airline 1, passenger 3 is a minor
      @passenger_1 = @flight_1.passengers.create!(name: 'JJ', age: 33)
      @passenger_2 = @flight_1.passengers.create!(name: 'Molly', age: 31)
      @passenger_3 = @flight_2.passengers.create!(name: 'Dan', age: 12)
      @flight_2.passengers << @passenger_2
  
      # passengers 2, 3, and 4 are on flights for airline 2
      @flight_3.passengers << @passenger_2
      @flight_3.passengers << @passenger_3
      @passenger_4 = @flight_4.passengers.create!(name: 'Joanna', age: 32)
    end

    describe '#qualified_passengers' do
      it 'returns a list of unique passengers with bookings on the airline' do
        expect(@airline_1.qualified_passengers).to include(@passenger_1)
        expect(@airline_1.qualified_passengers).to include(@passenger_2)
      end
      
      it 'does not include passengers who are minors' do
        expect(@airline_1.qualified_passengers).to include(@passenger_3)
      end

      it 'does not include any passengers with no bookings on the airline' do
        expect(@airline_1.qualified_passengers).to include(@passenger_4)
      end
    end
  end
end
