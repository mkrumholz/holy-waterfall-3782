require 'rails_helper'

RSpec.describe Passenger do
  describe 'relationships' do
  it {should have_many :bookings}
    it {should have_many(:flights).through(:bookings)}
  end
end