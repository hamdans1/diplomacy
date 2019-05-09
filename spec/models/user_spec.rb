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

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end

  end

  describe "roles" do

    it "is member by default" do
      expect(user.role).to eql("member")
    end

    context "member user" do
      it "returns true for #member" do
        expect(user.member?).to be_truthy
      end

      it "returns false for #admin" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #member" do
        expect(user.member?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(user.member?).to be_falsey
      end
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
