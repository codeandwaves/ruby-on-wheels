require 'rails_helper'

RSpec.describe Brand, type: :model do
  it "is not valid without an name" do
    expect(build(:brand, name: nil)).to_not be_valid
  end

  it "is not valid with duplicated name" do
    existing_brand_name = create(:brand).name
    expect(build(:brand, name: existing_brand_name)).to_not be_valid
  end
end
