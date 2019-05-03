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

  describe "GET edit" do
    it "returns http success" do
      get :edit, :params => {id: my_group.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the edit view" do
      get :edit, :params => {id: my_group.id}
      expect(response).to render_template :edit
    end

    it "assigns group to be update to @group" do
      get :edit, :params => {id: my_group.id}
      group_instance = assigns(:group)

      expect(group_instance.id).to eq(my_group.id)
      expect(group_instance.name).to eq(my_group.name)
      expect(group_instance.description).to eq(my_group.description)
    end
  end

  describe "PUT update" do
    it "updates group with expected attributes" do
      new_name = RandomData.random_sentence
      new_description = RandomData.random_sentence

      put :update, {:params => {:id => my_group.id, :group => {name: new_name, description: new_description}}}

      updated_group = assigns(:group)

      expect(updated_group.id).to eq my_group.id
      expect(updated_group.name).to eq new_name
      expect(updated_group.description).to eq new_description
    end

    it "redirects to the updated group" do
      new_name = RandomData.random_sentence
      new_description = RandomData.random_sentence

      put :update, {:params => {:id => my_group.id, :group => {name: new_name, description: new_description}}}
      expect(response).to redirect_to my_group
    end
  end

  describe "DELETE destroy" do
    it "deletes the topic" do
      delete :destroy, {:params => {:id => my_group.id}}
      count = Group.where({id: my_group.id}).size
      expect(count).to eq(0)
    end

    it "redirects to group index" do
      delete :destroy, {:params => {:id => my_group.id}}
      expect(response).to redirect_to groups_path
    end
  end
end
