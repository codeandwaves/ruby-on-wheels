FactoryBot.define do
  factory :brand do
    name { Faker::Vehicle.make }

    after :create do |brand|
      create :car, brand: brand
    end
  end
end
