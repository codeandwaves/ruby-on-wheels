class CarSerializer < BaseSerializer
  identifier :id

  fields :name, :mileage

  field :brand do |car|
    car.brand.name
  end
end
