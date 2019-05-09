module CampaignsHelper

  def user_is_authorized_for_campaign?(campaign)
    current_user && (current_user == campaign.user || current_user.admin?)
  end
end
