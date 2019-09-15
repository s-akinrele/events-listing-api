class Event < ApplicationRecord
  # Model associations
  has_many :bookings
  has_many :users, through: :bookings

  # Validations
  validates_presence_of :name, :description, :start_date, :end_date
end
