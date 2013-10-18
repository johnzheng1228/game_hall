module Playerable
	extend ActiveSupport::Concern
	
	module ClassMethods
		def login(login_params)
			login_result = {:id => 0,:token => ""}
			player = Player.find_by_name(login_params[:name])
			if player.password.eql?(encrypt(login_params[:password],player.serial_number))
				login_result[:id] = player.id
				login_result[:token] = generate_token(player.serial_number)
			end
			login_result
		end
		private

		def encrypt(value,salt)
			Digest::SHA1.hexdigest(value + salt)
		end
		def  generate_token(serial_number)
			Digest::SHA1.hexdigest(serial_number + Time.now.strftime("%Y%m%d"))
		end
	end
end