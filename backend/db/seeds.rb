require 'json'

##
# Get data from cars.json.
# Run: rails db:seed:create_cars_file to create the file
begin
  seed_cars = File.read(Rails.root.join('db', 'cars.json'))
  data_hash = JSON.parse(seed_cars, symbolize_names: true)

  # Add Cars and Brands
  puts "Creating Cars and Brands"
  data_hash.each do |h|
    brand = Brand.find_or_create_by(name: h[:brand])
    Car.create_with(brand: brand, mileage: rand(999999)).find_or_create_by(name: h[:name])
  end
rescue Errno::ENOENT => e
  puts "File with cars data does not exist. Run rails db:seed:create_cars_file to create it."
end

# Add users
puts "Creating User"
TOTAL_USERS = 3
USER_PASSWORD = 'supers3cr3t'

TOTAL_USERS.times do |idx|
  User.find_or_create_by(email: "row#{idx}@row-dev.com") do |user|
    user.password_digest = BCrypt::Password.create(USER_PASSWORD, cost: 5)
  end
end

# Add favorites
puts "Creating favorites"
TOTAL_FAVORITES = 5

TOTAL_FAVORITES.times do |_|
  Favorite.find_or_create_by(car: Car.all.sample, user: User.all.sample)
end
