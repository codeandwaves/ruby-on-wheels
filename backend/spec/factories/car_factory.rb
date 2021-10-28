FactoryBot.define do
  factory :car do
    name { Faker::Vehicle.model }
    brand
  end
end
