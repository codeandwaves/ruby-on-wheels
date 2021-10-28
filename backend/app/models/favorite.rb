class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :user, uniqueness: { scope: :car }
end
