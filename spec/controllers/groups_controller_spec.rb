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
end
