require 'rails_helper'

RSpec.describe Campaign, type: :model do
  let(:name) {RandomData.random_sentence}
  let(:title) {RandomData.random_sentence}
  let(:scoring) {RandomData.random_sentence}
  let(:description){RandomData.random_sentence}

  let(:group) {Group.create!(name: name, description: description)}
  let(:campaign) {group.campaigns.create!(title: title, scoring: scoring)}

  describe "attributes" do
    it "has title and scoring attributes" do
      expect(campaign).to have_attributes(title: title, scoring: scoring)
    end
  end
end
