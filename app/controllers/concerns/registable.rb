class Registable
  extend ActiveSupport::Concern
  BASE_ID = 10000
  
  def init_player_info
    self.name = BASE_ID + id
    self.password = generate_password
    self.nick_name = "player#{player.id}"
    self.save
  end

  private

  def generate_password

  end
end