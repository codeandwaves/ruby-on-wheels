class FavoriteSerializer < BaseSerializer
  association :car, blueprint: CarSerializer
end
