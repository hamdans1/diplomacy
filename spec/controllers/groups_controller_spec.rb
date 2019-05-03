require 'rails_helper'

RSpec.describe GroupsController, type: :controller do

  let(:my_group) {Group.create!(name: RandomData.random_sentence, description: RandomData.random_sentence)}

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_group to @groups" do
      get :index
      expect(assigns(:groups)).to eq([my_group])
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, :params => {id: my_group.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, :params => {id: my_group.id}
      expect(response).to render_template :show
    end

    it "assigns my_group to @group" do
      get :show, :params => {id: my_group.id}
      expect(assigns(:group)).to eq (my_group)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new view" do
      get :new
      expect(response).to render_template :new
    end

    it "initializes @group" do
      get :new
      expect(assigns(:group)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the amount of groups by 1" do
      expect {post :create, :params => { :group => {name: RandomData.random_sentence, description: RandomData.random_sentence}}}.to change(Group, :count).by(1)
    end

    it "assigns Group.last to @group" do
      post :create, :params => {:group => {name: RandomData.random_sentence, description: RandomData.random_sentence}}
      expect(assigns(:group)).to eq Group.last
    end

    it "redirects to the newly created group" do
      post :create, :params => {:group => {name: RandomData.random_sentence, description: RandomData.random_sentence}}
      expect(response).to redirect_to Group.last
    end
  end
end
