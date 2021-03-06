FactoryBot.define do
  factory :event do
    name { Faker::Name.name }
    description { Faker::Lorem.word }
    start_date { Faker::Date.backward(days: 14) }
    end_date { Faker::Date.forward(days: 23) }
    image_url { "https://via.placeholder.com/150" }
  end
end
