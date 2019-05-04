require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Campaign, type: :model do
  let(:name) {RandomData.random_sentence}
  let(:title) {RandomData.random_sentence}
  let(:scoring) {RandomData.random_sentence}
  let(:description){RandomData.random_sentence}

  let(:group) {Group.create!(name: name, description: description)}
  let(:campaign) {group.campaigns.create!(title: title, scoring: scoring)}

   it { is_expected.to belong_to(:group) }

   it { is_expected.to validate_presence_of(:title)}
   it { is_expected.to validate_presence_of(:scoring)}

   it { is_expected.to validate_length_of(:title).is_at_least(3)}
   it { is_expected.to validate_length_of(:scoring).is_at_least(3)}

  describe "attributes" do
    it "has title and scoring attributes" do
      expect(campaign).to have_attributes(title: title, scoring: scoring, group: group)
    end
  end
end
