FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@row.test" }
    password { 'supers3cr3t' }
    password_confirmation { 'supers3cr3t' }
    # password_digest { BCrypt::Password.create('supers3cr3t', cost: 5) }
  end
end
