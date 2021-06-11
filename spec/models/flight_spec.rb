require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many :bookings}
    it {should have_many(:passengers).through(:bookings)}
  end 
  
  describe 'instance methods' do
    before :each do
      @airline_1 = Airline.create!(name: 'Icelandair')
      
      @flight_1 = @airline_1.flights.create!(number: "1234", date: Date.parse('2021-06-01'), departure_city: 'New York', arrival_city: 'Reykjavik')
    end  

    describe '#airline_name' do
      it 'returns the name of the flight\'s airline' do
        expect(@flight_1.airline_name).to eq @airline_1.name
      end
    end
  end
end
