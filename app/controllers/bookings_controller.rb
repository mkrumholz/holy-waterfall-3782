class BookingsController < ApplicationController
  def destroy
    booking = Booking.find(params[:id])
    if booking.present?
      booking.destroy 
    end
    redirect_to flights_path
  end
end