class User < ApplicationRecord
  has_secure_password

  has_many :favorites, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def generate_jwt
    JWT.encode(
      {
        id: self.id,
        exp: 60.days.from_now.to_i
      },
      Rails.application.secrets.secret_key_base
    )
  end

  def favorite_cars
    self.favorites&.map(&:car)
  end
end
