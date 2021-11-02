require 'rails_helper'

RSpec.describe "BaseSerializer" do

  context "Object is a Car object" do
    it "should instantiate a CarSerializer object" do
      expect(BaseSerializer.send(:resource_serializer_class, create(:car))).to eq(CarSerializer)
    end

  end

  context "Object is a collection of Car objects" do
    it "should instantiate a CarSerializer object" do
      expect(BaseSerializer.send(:resource_serializer_class, create_list(:car, 3))).to eq(CarSerializer)
    end
  end

  it "should contain car attribute keys" do
    expect(BaseSerializer.render(create(:car)).keys).to  eq(["id", "brand", "mileage", "name"])
  end
end
