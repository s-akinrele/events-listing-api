class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_date, :end_date, :image_url, :attendees_count
  has_many :users

  def attendees_count
    object.users.size
  end
end
