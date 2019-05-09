require 'rails_helper'
include RandomData
include SessionsHelper

RSpec.describe CampaignsController, type: :controller do

  let(:my_user) {User.create!(name:"DiploUser", email: "user@diplo.com", password: "helloworld")}
  let(:other_user) {User.create!(name: RandomData.random_sentence, email: RandomData.random_sentence, password: "helloworld", role: :member)}
  let(:my_group) { Group.create!(name: RandomData.random_sentence, description: RandomData.random_sentence)}
  let(:my_campaign) {my_group.campaigns.create!(title: RandomData.random_sentence, scoring: RandomData.random_sentence, user: my_user)}

  context "guest user" do

    describe "GET show" do
      it "returns http success" do
        get :show, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(response).to render_template :show
      end

      it "assigns my_campaign to @campaign" do
        get :show, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(assigns(:campaign)).to eq(my_campaign)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new, :params => {group_id: my_group.id}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, :params => {group_id: my_group.id, campaign: {title: RandomData.random_sentence, scoring: RandomData.random_sentence}}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_scoring = RandomData.random_scoring
        put :update, :params => {group_id: my_group.id, id: my_campaign.id, campaign: {title: new_title, scoring: new_scoring}}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "member user performing task on another post" do

    before do
      create_session(my_user)
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(response).to render_template :show
      end

      it "assigns my_campaign to @campaign" do
        get :show, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(assigns(:campaign)).to eq(my_campaign)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new, :params => {group_id: my_group.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, :params => {group_id: my_group.id}
        expect(response).to render_template :new
      end

      it "instantiates @campaign" do
        get :new, :params => {group_id: my_group.id}
        expect(assigns(:campaign)).not_to be_nil
      end
    end


    describe "POST create" do
      it "increases the number of Campaign by 1" do
        expect {post :create, :params => { :group_id => my_group.id, :campaign => {title: RandomData.random_sentence, scoring: RandomData.random_sentence}}}.to change(Campaign, :count).by(1)
      end

      it "assigns the new campaign to @campaign" do
        post :create, :params =>  {:group_id => my_group.id, :campaign => {title: RandomData.random_sentence, scoring: RandomData.random_sentence}}
        expect(assigns(:campaign)).to eq Campaign.last
      end

      it "redirects to the new campaign" do
        post :create, :params => {:group_id => my_group.id, :campaign => {title: RandomData.random_sentence, scoring: RandomData.random_sentence}}
        expect(response).to redirect_to [my_group, Campaign.last]
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(response).to redirect_to [my_group, my_campaign]
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_scoring = RandomData.random_scoring

        put :update, :params => {group_id: my_group.id, id: my_campaign.id, campaign: {title: new_title, scoring: new_scoring}}
        expect(response).to redirect_to([my_group, my_campaign])
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(response).to redirect_to [my_group, my_campaign]
      end
    end
  end

  context "member user performing action on their own post" do

    before do
      create_session(other_user)
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(response).to render_template :show
      end

      it "assigns my_campaign to @campaign" do
        get :show, :params => {group_id: my_group.id, id: my_campaign.id}
        expect(assigns(:campaign)).to eq(my_campaign)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new, :params => {group_id: my_group.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, :params => {group_id: my_group.id}
        expect(response).to render_template :new
      end

      it "instantiates @campaign" do
        get :new, :params => {group_id: my_group.id}
        expect(assigns(:campaign)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Campaign by 1" do
        expect {post :create, :params => { :group_id => my_group.id, :campaign => {title: RandomData.random_sentence, scoring: RandomData.random_sentence}}}.to change(Campaign, :count).by(1)
      end

      it "assigns the new campaign to @campaign" do
        post :create, :params =>  {:group_id => my_group.id, :campaign => {title: RandomData.random_sentence, scoring: RandomData.random_sentence}}
        expect(assigns(:campaign)).to eq Campaign.last
      end

      it "redirects to the new campaign" do
        post :create, :params => {:group_id => my_group.id, :campaign => {title: RandomData.random_sentence, scoring: RandomData.random_sentence}}
        expect(response).to redirect_to [my_group, Campaign.last]
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, :params => { :group_id => my_group.id, id: my_campaign.id}
        expect(response).to have_http_status(:success)
      end

      it "returns the #edit view" do
        get :edit, :params => { :group_id => my_group.id, id: my_campaign.id}
        expect(response).to render_template :edit
      end

      it "assigns campaign to be updated to @campaign" do
        get :edit, :params => { :group_id => my_group.id, id: my_campaign.id}
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

        put :update, {:params => {:group_id => my_group.id, :id => my_campaign.id, :campaign => {title: new_title, scoring: new_scoring}}}

        updated_campaign = assigns(:campaign)
        expect(updated_campaign.id).to eq my_campaign.id
        expect(updated_campaign.title).to eq new_title
        expect(updated_campaign.scoring).to eq new_scoring
      end

      it "redirects to the updated post" do
        new_title = RandomData.random_sentence
        new_scoring = RandomData.random_sentence

        put :update, {:params => {:group_id => my_group.id, :id => my_campaign.id, :campaign => {title: new_title, scoring: new_scoring}}}
        expect(response).to redirect_to [my_group, my_campaign]
      end
    end

    describe "DELETE destroy" do
      it "deletes the campaign" do
        delete :destroy, {:params => {:group_id => my_group.id, :id => my_campaign.id}}
        count = Campaign.where({id: my_campaign.id}).size
        expect(count).to eq(0)
      end

      it "redirects to group show" do
        delete :destroy, {:params => {:group_id => my_group.id, :id => my_campaign.id}}
        expect(response).to redirect_to my_group
      end
    end
  end
end
