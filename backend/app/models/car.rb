class Car < ApplicationRecord
  has_many :favorites, as: :likeable
  belongs_to :brand, optional: false

  validates :name, presence: true, uniqueness: { scope: :brand, message: "should happen once per brand" }
  validates :mileage, allow_nil: true, numericality: { only_integer: true }
end
