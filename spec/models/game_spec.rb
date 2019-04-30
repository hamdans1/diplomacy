require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:campaign) {Campaign.create!(title:"2019 Season", scoring:"Classic")}
  let(:game) {Game.create!(title:"Kaiserfest4", scoring:"Tournament", map: "Classic", style:"Anonymous", campaign: campaign)}

  describe "attributes" do
    it "has title, scoring, map, style, and campaign attributes" do
      expect(game).to have_attributes(title:"Kaiserfest4", scoring:"Tournament", map:"Classic", style:"Anonymous")
    end
  end
end
