module GamesHelper

  def user_is_authorized_for_game?(game)
    current_user && (current_user == game.user || current_user.admin?)
  end
  
end
