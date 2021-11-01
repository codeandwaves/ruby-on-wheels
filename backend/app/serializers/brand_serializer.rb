class BrandSerializer < Blueprinter::Base
  identifier :id

  fields :name
  association :cars, blueprint: CarSerializer
end
