require 'rails_helper'

RSpec.describe Car, type: :model do

  it "is not valid without an name" do
    expect(build(:car, name: nil)).to_not be_valid
  end

  it "is not valid with duplicated name for the same brand" do
    brand_ford = build(:brand, name: "ford")
    car = create(:car, brand: brand_ford)
    expect(build(:car, name: car.name, brand: brand_ford)).to_not be_valid
  end

  it "is valid with same name for different brands" do
    brand_1 = create(:brand)
    brand_2 = create(:brand)
    car = create(:car, brand: brand_1)
    expect(build(:car, name: car.name, brand: brand_2)).to be_valid
  end
end

