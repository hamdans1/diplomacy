require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.create!(name:"DiploUser", email:"user@diplomacy.com", password:"password")}

  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_length_of(:name).is_at_least(3)}

  it { is_expected.to validate_presence_of(:email)}
  it { is_expected.to validate_uniqueness_of(:email)}
  it { is_expected.to validate_length_of(:email).is_at_least(3)}
  it { is_expected.to allow_value("user@diplomacy.com").for(:email)}

  it { is_expected.to validate_presence_of(:password)}
  it { is_expected.to validate_length_of(:password).is_at_least(8)}
  it { is_expected.to have_secure_password}

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: "DiploUser", email: "user@diplomacy.com")
    end
  end
  
end
