require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:name) {RandomData.random_sentence}
  let(:public) {true}
  let(:description) {RandomData.random_sentence}
  let(:group) {Group.create!(name:name, description: description)}

  it {should have_many(:campaigns)}

  describe "attributes" do
    it "has name and description attributes" do
      expect(group).to have_attributes(name: name, description: description)
    end

    it "is public by default" do
      expect(group.public).to be(true)
    end
  end

end
