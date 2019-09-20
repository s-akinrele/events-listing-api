class BookingsController < ApplicationController
  def create
    booking = Booking.create!(bookings_params)
    event = booking.event
    render json: event, each_serializer: EventSerializer, status: :ok
  end

  private

  def bookings_params
    params.permit(:user_id, :event_id)
  end
end
