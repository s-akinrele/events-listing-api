class BookingsController < ApplicationController
  def create
    booking = Booking.create!(bookings_params)
    event = booking.event
    json_response({event: event}, :created)
  end

  private

  def bookings_params
    params.permit(:user_id, :event_id)
  end
end
