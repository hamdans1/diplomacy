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
end
