module GroupsHelper

  def user_is_authorized_for_groups?
    current_user && current_user.admin?
  end
end
