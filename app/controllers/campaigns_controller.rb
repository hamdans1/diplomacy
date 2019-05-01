class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new
    @campaign.title = params[:campaign][:title]
    @campaign.scoring = params[:campaign][:scoring]

    if @campaign.save
      flash[:notice] = "Post was saved."
      redirect_to @campaign
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
    @campaign.title = params[:campaign][:title]
    @campaign.scoring = params[:campaign][:scoring]

    if @campaign.save
      flash[:notice] = "Your campaign has been updated"
      redirect_to @campaign
    else
      flash.now[:alert] = "There was an error saving your campaign. Please Try again"
      render :edit
    end
  end
end
