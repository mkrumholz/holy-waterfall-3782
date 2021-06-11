require 'rails_helper'

RSpec.describe 'flight index' do
  before :each do
    @airline_1 = Airline.create!(name: 'Icelandair')
    @airline_2 = Airline.create!(name: 'Korean Air')

    # flights for airline 1
    @flight_1 = @airline_1.flights.create!(number: "1234", date: Date.parse('2021-06-01'), departure_city: 'New York', arrival_city: 'Reykjavik')
    @flight_2 = @airline_1.flights.create!(number: "1345", date: Date.parse('2021-06-07'), departure_city: 'Reykjavik', arrival_city: 'Paris')

    # flights for airline 2
    @flight_3 = @airline_2.flights.create!(number: "2234", date: Date.parse('2021-06-01'), departure_city: 'Houston', arrival_city: 'Los Angeles')
    @flight_4 = @airline_2.flights.create!(number: "2345", date: Date.parse('2021-06-07'), departure_city: 'Los Angeles', arrival_city: 'Seoul')

    # passengers 1 & 2 are on flight 1
    @passenger_1 = @flight_1.passengers.create!(name: 'JJ', age: 33)
    @passenger_2 = @flight_1.passengers.create!(name: 'Molly', age: 31)

    # passengers 3 & 4 are on flight 2
    @passenger_3 = @flight_2.passengers.create!(name: 'Dan', age: 32)
    @passenger_4 = @flight_2.passengers.create!(name: 'Joanna', age: 32)

    # passengers 1 & 3 are on flight 3
    @flight_3.passengers << @passenger_1
    @flight_3.passengers << @passenger_3

    # passengers 2 & 4 are on flight 4
    @flight_4.passengers << @passenger_2
    @flight_4.passengers << @passenger_4

    visit '/flights'
  end
  it 'has a list of all flight numbers' do
    expect(page).to have_content @flight_1.number
    expect(page).to have_content @flight_2.number
    expect(page).to have_content @flight_3.number
    expect(page).to have_content @flight_4.number
  end

  it 'displays the airline for each flight' do
    within "div#flight-#{@flight_1.id}" do
      expect(page).to have_content @airline_1.name
    end
    within "div#flight-#{@flight_2.id}" do
      expect(page).to have_content @airline_1.name
    end
    within "div#flight-#{@flight_3.id}" do
      expect(page).to have_content @airline_2.name
    end
    within "div#flight-#{@flight_4.id}" do
      expect(page).to have_content @airline_2.name
    end
  end

  it 'displays all passengers for each flight' do
    within "div#flight-#{@flight_1.id}" do
      expect(page).to have_content @passenger_1.name
      expect(page).to have_content @passenger_2.name
    end
    within "div#flight-#{@flight_2.id}" do
      expect(page).to have_content @passenger_2.name
      expect(page).to have_content @passenger_3.name
    end
    within "div#flight-#{@flight_3.id}" do
      expect(page).to have_content @passenger_1.name
      expect(page).to have_content @passenger_3.name
    end
    within "div#flight-#{@flight_4.id}" do
      expect(page).to have_content @passenger_2.name
      expect(page).to have_content @passenger_4.name
    end
  end
end