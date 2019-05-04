require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:name) {RandomData.random_sentence}
  let(:public) {true}
  let(:description) {RandomData.random_sentence}
  let(:group) {Group.create!(name:name, description: description)}

  it { is_expected.to have_many(:campaigns)}

  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_presence_of(:description)}
  it { is_expected.to validate_length_of(:name).is_at_least(3)}
  it { is_expected.to validate_length_of(:description).is_at_least(10)}

  describe "attributes" do
    it "has name and description attributes" do
      expect(group).to have_attributes(name: name, description: description)
    end

    it "is public by default" do
      expect(group.public).to be(true)
    end
  end

end
