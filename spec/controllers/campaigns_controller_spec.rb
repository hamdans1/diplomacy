require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do

  let(:my_campaign) {Campaign.create!(title: "2018 Campaign", scoring:"Classic")}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_campaign] to @campaigns" do
      get :index
      expect(assigns(:campaigns)).to eq([my_campaign])
    end
  end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @campaign" do
      get :new
      expect(assigns(:campaign)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of Campaign by 1" do
      expect{post :create, campaign: {title: RandomData.random_sentence, scoring: RandomData.random_sentence}}.to change(Campaign, :count).by(1)
    end

    it "assigns the new campaign to @campaign" do
      post :create, campaign: {title: RandomData.random_sentence, scoring: RandomData.random_sentence}
      expect(assigns(:campaign)).to eq Campaign.last
    end

    it "redirects to the new campaign" do
      post :create, campaign: {title: RandomData.random_sentence, scoring: RandomData.random_sentence}
      expect(response).to redirect_to Campaign.last
    end
  end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
