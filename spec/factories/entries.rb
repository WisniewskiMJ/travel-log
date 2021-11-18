FactoryBot.define do
  factory :entry do
    location { Faker::Address.city }
    note { Faker::Lorem.sentence }
    temperature { Faker::Number.between(from: -10, to: 40) }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end 