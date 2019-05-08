require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.create!(name:"DiploUser", email:"user@diplomacy.com", password:"password")}

  it {is_expected.to have_many(:campaigns)}

  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_length_of(:name).is_at_least(3)}

  it { is_expected.to validate_presence_of(:email)}
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive}
  it { is_expected.to validate_length_of(:email).is_at_least(7)}
  it { is_expected.to allow_value("user@diplomacy.com").for(:email)}

  it { is_expected.to validate_presence_of(:password)}
  it { is_expected.to validate_length_of(:password).is_at_least(8)}
  it { is_expected.to have_secure_password}

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: "DiploUser", email: "user@diplomacy.com")
    end
  end

  describe "invalid user" do
    let (:user_with_invalid_name) {User.new(name: "", email: "user@diplomacy.com")}
    let (:user_with_invalid_email) {User.new(name:"DiploUser", email:"")}

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

end
