require 'rails_helper'

RSpec.describe Campaign, type: :model do
  let(:campaign) {Campaign.create!(title:"2019 Season", scoring:"Classic")}

  describe "attributes" do
    it "has title and scoring attributes" do
      expect(campaign).to have_attributes(title: "2019 Season", scoring: "Classic")
    end
  end
end
