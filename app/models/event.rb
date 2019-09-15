class Event < ApplicationRecord
  validates_presence_of :name, :description, :start, :end
end
