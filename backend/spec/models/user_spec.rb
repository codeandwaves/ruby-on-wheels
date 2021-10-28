require 'rails_helper'

RSpec.describe User, type: :model do
  it "is not valid without an email" do
    expect(build(:user, email: nil)).to_not be_valid
  end

  it "is not valid without a password" do
    expect(build(:user, password_digest: nil)).to_not be_valid
  end

  it "is not valid with repeated email" do
    email_already_used = create(:user).email
    expect(build(:user, email: email_already_used)).to_not be_valid
  end
end
