class Car < ApplicationRecord
  has_many :favorites, dependent: :destroy
  belongs_to :brand, optional: false

  validates :name, presence: true, uniqueness: { scope: :brand, message: "should happen once per brand" }
  validates :mileage, allow_nil: true, numericality: { only_integer: true }

  scope :order_by_favorites, ->() {
    joins("FULL JOIN favorites ON favorites.car_id = cars.id")
    .select("cars.name, cars.mileage, COUNT(favorites) as favs")
    .group("cars.name, cars.mileage")
    .order("favs DESC, cars.mileage ASC")
  }
end
