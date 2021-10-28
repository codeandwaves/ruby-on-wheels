FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "#{Faker::Vehicle.make}#{n}" }

    after :create do |brand|
      create :car, brand: brand
    end
  end
end
