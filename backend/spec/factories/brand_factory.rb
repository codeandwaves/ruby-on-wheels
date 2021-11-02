FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "#{Faker::Vehicle.make}#{n}" }
  end
end
