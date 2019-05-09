class CampaignsController < ApplicationController

  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: [:show, :new, :create]

  def show
    @campaign = Campaign.find(params[:id])
  end

  def new
    @group = Group.find(params[:group_id])
    @campaign = Campaign.new
  end

  def create
    @group = Group.find(params[:group_id])
    @campaign = @group.campaigns.build(campaign_params)
    @campaign.user = current_user

    if @campaign.save
      flash[:notice] = "Post was saved."
      redirect_to [@group, @campaign]
    else
      flash.now[:alert] = "There was an error saving your post. Please try again."
      render :new
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    @campaign.assign_attributes(campaign_params)

    if @campaign.save
      flash[:notice] = "Your campaign has been updated"
      redirect_to [@campaign.group, @campaign]
    else
      flash.now[:alert] = "There was an error saving your campaign. Please Try again"
      render :edit
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])

    if @campaign.destroy
      flash[:notice] = "#{@campaign.title} was deleted successfully."
      redirect_to @campaign.group
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :scoring)
  end

  def authorize_user
    campaign = Campaign.find(params[:id])

    unless current_user == campaign.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to [campaign.group, campaign]
    end
  end

end
