class CarSerializer < Blueprinter::Base
  identifier :id

  fields :name, :mileage

  field :brand do |car|
    car.brand.name
  end
end
