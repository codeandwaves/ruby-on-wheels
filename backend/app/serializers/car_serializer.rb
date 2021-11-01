class CarSerializer < Blueprinter::Base
  identifier :id

  fields :name, :mileage
  association :brand, blueprint: BrandSerializer
end
