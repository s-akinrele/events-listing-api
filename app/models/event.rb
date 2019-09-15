class Event < ApplicationRecord
  validates_presence_of :name, :description, :start_date, :end_date
end
