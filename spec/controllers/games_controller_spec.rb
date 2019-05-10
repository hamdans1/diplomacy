require 'rails_helper'
include SessionsHelper

RSpec.describe GamesController, type: :controller do

  let(:my_user) {User.create!(name:"DiploUser", email: "user@diplo.com", password: "helloworld")}
  let(:other_user) {User.create!(name: RandomData.random_word, email: RandomData.random_sentence, password: "helloworld", role: :member)}
  let(:my_group) { Group.create!(name: RandomData.random_sentence, description: RandomData.random_sentence)}
  let(:my_campaign) {my_group.campaigns.create!(title: RandomData.random_sentence, scoring: RandomData.random_scoring, user: my_user)}
  let(:my_game) {Game.create!(title: RandomData.random_sentence, scoring: RandomData.random_scoring, style: RandomData.random_style, map: RandomData.random_sentence, campaign: my_campaign, user: my_user)}

  context "guest" do

    describe "POST create" do
      it "redirects the user to the sign in view" do
        post :create, :params => {campaign_id: my_campaign.id, comment: {title: RandomData.random_sentence, scoring: RandomData.random_scoring, style: RandomData.random_style, map: RandomData.random_sentence}}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects the user to the sign in view" do
        delete :destroy, :params => {campaign_id: my_campaign.id, id: my_game.id}
        expect(response).to redirect_to(new_session_path)
      end
    end

  end

  context "member user doing CRUD on a comment they don't own" do
    before do
      create_session(other_user)
    end

    describe "POST create" do

      it "increases the number of games by 1" do
        expect{ post :create, :params => {campaign_id: my_campaign.id, game: {title: RandomData.random_sentence, scoring: RandomData.random_scoring, style: RandomData.random_style, map: RandomData.random_sentence}}}.to change(Game, :count).by(1)
      end

      it "redirects to the post show view" do
        post :create, :params => {campaign_id: my_campaign.id, game: {title: RandomData.random_sentence, scoring: RandomData.random_scoring, style: RandomData.random_style, map: RandomData.random_sentence}}
        expect(response).to redirect_to [my_group, my_campaign]
      end

    end

    describe "DELETE destroy" do
      it "redirects the user to the posts show view" do
        delete :destroy, :params => {campaign_id: my_campaign.id, id: my_game.id}
        expect(response).to redirect_to([my_group, my_campaign])
      end
    end

  end

  context "member user doing CRUD on a comment they own" do
    before do
      create_session(my_user)
    end

    describe "POST create" do
      it "increases the number of comments by 1" do
        expect{ post :create, :params => {campaign_id: my_campaign.id, game: {title: RandomData.random_sentence, scoring: RandomData.random_scoring, style: RandomData.random_style, map: RandomData.random_sentence}}}.to change(Game, :count).by(1)
      end

      it "redirects to the post show view" do
        post :create, :params => {campaign_id: my_campaign.id, game: {title: RandomData.random_sentence, scoring: RandomData.random_scoring, style: RandomData.random_style, map: RandomData.random_sentence}}
        expect(response).to redirect_to [my_group, my_campaign]
      end
    end

    describe "DELETE destroy" do
      it "deletes the comment" do
        delete :destroy, :params => {campaign_id: my_campaign.id, id: my_game.id}
        count = Game.where({id: my_game.id}).count
        expect(count).to eq 0
      end

      it "redirects to the post show view" do
        delete :destroy, :params => {campaign_id: my_campaign.id, id: my_game.id}
        expect(response).to redirect_to([my_group, my_campaign])
      end
    end
  end


  context "admin user doing CRUD on a comment they don't own" do
    before do
      other_user.admin!
      create_session(other_user)
    end

    describe "POST create" do
      it "increases the number of comments by 1" do
        expect{ post :create, :params => {campaign_id: my_campaign.id, game: {title: RandomData.random_sentence, scoring: RandomData.random_scoring, style: RandomData.random_style, map: RandomData.random_sentence}}}.to change(Game, :count).by(1)
      end

      it "redirects to the post show view" do
        post :create, :params => {campaign_id: my_campaign.id, game: {title: RandomData.random_sentence, scoring: RandomData.random_scoring, style: RandomData.random_style, map: RandomData.random_sentence}}
        expect(response).to redirect_to [my_group, my_campaign]
      end
    end

    describe "DELETE destroy" do
      it "deletes the comment" do
        delete :destroy, :params => {campaign_id: my_campaign.id, id: my_game.id}
        count = Game.where({id: my_game.id}).count
        expect(count).to eq 0
      end

      it "redirects to the post show view" do
        delete :destroy, :params => {campaign_id: my_campaign.id, id: my_game.id}
        expect(response).to redirect_to([my_group, my_campaign])
      end
    end
  end



end
