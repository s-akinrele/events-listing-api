class BookingsController < ApplicationController
  def create
    booking = Booking.create!(bookings_params)
    json_response({booking: booking}, :created)
  end

  private

  def bookings_params
    params.permit(:user_id, :event_id)
  end
end
