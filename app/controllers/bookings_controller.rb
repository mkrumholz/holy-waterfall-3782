class BookingsController < ApplicationController
  def destroy
    booking = Booking.find(params[:id])
    if booking.present?
      booking.destroy
      redirect_to flights_path
    else
      redirect_to flights_path
      flash[:alert] = "Error: No bookings found for this passenger"
    end
  end
end