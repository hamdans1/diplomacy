class GamesController < ApplicationController

  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    @campaign = Campaign.find(params[:campaign_id])
    game = @campaign.games.new(game_params)
    game.user = current_user

    if game.save
      flash[:notice] = "Game was saved successfully"
      redirect_to [@campaign.group, @campaign]
    else
      flash[:alert] = "Game failed to save"
      redirect_to [@campaign.group, @campaign]
    end
  end

  def destroy
    @campaign = Campaign.find(params[:campaign_id])
    game = @campaign.games.find(params[:id])

    if game.destroy
      flash[:notice] = "Game was destroyed"
      redirect_to [@campaign.group, @campaign]
    else
      flash[:alert] = "Game could not be destroyed. Try again"
      redirect_to [@campaign.group, @campaign]
    end
  end


  private

  def game_params
    params.require(:game).permit(:title, :scoring, :style, :map)
  end

  def authorize_user
    game = Game.find(params[:id])
    unless current_user == game.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete this game."
      redirect_to [game.campaign.group, game.campaign]
    end
  end
  
end
