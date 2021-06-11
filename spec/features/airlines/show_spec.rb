require 'rails_helper'

RSpec.describe 'airline show page' do
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

    visit "/airlines/#{@airline_1.id}"
  end

  it 'displays the airline name' do
    expect(page).to have_content @airline_1.name
    expect(page).to_not have_content @airline_2.name
  end

  it 'has a list of unique passengers with flights on that airline' do
    expect(page).to have_content(@passenger_1.name, count: 1)
    expect(page).to have_content(@passenger_2.name, count: 1)
  end
  
  it 'does not display minors (only adult passengers)' do
    expect(page).to_not have_content @passenger_3.name
  end

  it 'does not display passengers who are only flying on another airline' do
    expect(page).to_not have_content @passenger_4.name
  end
end