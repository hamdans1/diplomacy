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

  describe "GET #show" do
    it "returns http success" do
      get :show, :params => {id: my_campaign.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, :params => {id: my_campaign.id}
      expect(response).to render_template :show
    end

    it "assigns my_campaign to @campaign" do
      get :show, :params => {id: my_campaign.id}
      expect(assigns(:campaign)).to eq(my_campaign)
    end
  end

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
      expect {post :create, :params => { :campaign => {title: RandomData.random_sentence, scoring: RandomData.random_sentence}}}.to change(Campaign, :count).by(1)
    end

    it "assigns the new campaign to @campaign" do
      post :create, :params =>  {:campaign => {title: RandomData.random_sentence, scoring: RandomData.random_sentence}}
      expect(assigns(:campaign)).to eq Campaign.last
    end

    it "redirects to the new campaign" do
      post :create, :params => {:campaign => {title: RandomData.random_sentence, scoring: RandomData.random_sentence}}
      expect(response).to redirect_to Campaign.last
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, :params => {id: my_campaign.id}
      expect(response).to have_http_status(:success)
    end

    it "returns the #edit view" do
      get :edit, :params => {id: my_campaign.id}
      expect(response).to render_template :edit
    end

    it "assigns campaign to be updated to @campaign" do
      get :edit, :params => {id: my_campaign.id}
      campaign_instance = assigns(:campaign)

      expect(campaign_instance.id).to eq my_campaign.id
      expect(campaign_instance.title).to eq my_campaign.title
      expect(campaign_instance.scoring).to eq my_campaign.scoring
    end
  end

  describe "PUT update" do
    it "updates post with expected attribute" do
      new_title = RandomData.random_sentence
      new_scoring = RandomData.random_sentence

      put :update, {:params => {:id => my_campaign.id, :campaign => {title: new_title, scoring: new_scoring}}}

      updated_campaign = assigns(:campaign)
      expect(updated_campaign.id).to eq my_campaign.id
      expect(updated_campaign.title).to eq new_title
      expect(updated_campaign.scoring).to eq new_scoring
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_scoring = RandomData.random_sentence

      put :update, {:params => {:id => my_campaign.id, :campaign => {title: new_title, scoring: new_scoring}}}
      expect(response).to redirect_to my_campaign
    end
  end

  describe "DELETE destroy" do
    it "deletes the campaign" do
      delete :destroy, {:params => {:id => my_campaign.id}}
      count = Campaign.where({id: my_campaign.id}).size
      expect(count).to eq(0)
    end

    it "redirects to campaign index" do
      delete :destroy, {:params => {:id => my_campaign.id}}
      expect(response).to redirect_to campaigns_path
    end
  end

end
