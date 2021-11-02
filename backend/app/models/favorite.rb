class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :car, uniqueness: { scope: :user, message: "already on your favorites" }
end
