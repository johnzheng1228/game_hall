class RegistController < ApplicationController

  def quick
    serial_number = params[:deviceid]
    player = Player.create(:name=>Time.now.to_i,:serial_number => serial_number)
    player.init_base_info
    render :json => player.json_format
  end

  def normal
    player = Player.create(player_params)
    regist_result = player.regist_result
    
    render :json => regist_result
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def player_params
    if params[:password].present? && params[:password].eql?(params[:re_password])
      {
        :serial_number => params[:deviceid],
        :token => generate_token(params[:deviceid]),
        :name => params[:name],
        :password => encrypt(params[:password],params[:deviceid]),
        :nick_name => params[:nickname]
      }
    end
  end

  def encrypt(value,salt)
    Digest::SHA1.hexdigest(value + salt)
  end


  def  generate_token(serial_number)
    Digest::SHA1.hexdigest(serial_number + Time.now.strftime("%Y%m%d"))
  end
end
