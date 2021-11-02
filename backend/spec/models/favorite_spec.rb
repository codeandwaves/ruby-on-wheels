require 'rails_helper'

RSpec.describe Favorite, type: :model do
  it "is not possible to have a user with 2 favorites of the same car" do
    favorite = create(:favorite)
    expect(build(:favorite, user: favorite.user, car: favorite.car)).to_not be_valid
  end
end
