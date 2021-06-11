require 'rails_helper'

RSpec.describe Booking do
  describe 'relationships' do
    it {should belong_to :passenger}
    it {should belong_to :flight}
  end
end