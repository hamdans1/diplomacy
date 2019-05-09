require 'rails_helper'

RSpec.describe Game, type: :model do

  let(:group){Group.create!(name: RandomData.random_sentence, description: RandomData.random_sentence)}
  let(:user) {User.create!(name:"DiploUser", email: "user@diplo.com", password: "helloworld")}
  let(:campaign){group.campaigns.create!(title: RandomData.random_sentence, scoring: RandomData.random_sentence, user: user)}

  let(:title){RandomData.random_sentence}
  let(:scoring){RandomData.random_scoring}
  let(:map){RandomData.random_sentence}
  let(:style){RandomData.random_style}

  let(:game){Game.create!(title: title, scoring: scoring, map: map, style: style, campaign: campaign, user: user)}

    it {is_expected.to belong_to(:campaign)}
    it {is_expected.to belong_to(:user)}

    it {is_expected.to validate_presence_of(:title)}
    it {is_expected.to validate_presence_of(:scoring)}
    it {is_expected.to validate_presence_of(:map)}
    it {is_expected.to validate_presence_of(:style)}

    it {is_expected.to validate_length_of(:title).is_at_least(4)}
    it {is_expected.to validate_length_of(:map).is_at_least(4)}


  describe "attributes" do
    it "has title, scoring, map, style, and campaign attributes" do
      expect(game).to have_attributes(title: title, scoring: scoring, map: map, style: style, campaign: campaign)
    end
  end
end
