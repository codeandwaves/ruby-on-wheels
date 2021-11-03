class CarSerializer < BaseSerializer

  fields :id do |cars|
    cars.id
  end

  fields :name, :mileage

  # field :brand do |car|
  #   car.brand.name
  # end

  field :favs do |car|
    car.try(:favs)
  end
end
