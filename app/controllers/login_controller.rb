class LoginController < ApplicationController
	def login
		longin_result = Player.login(login_params)
		render :json => longin_result
	end

	def app
		# player = Player.find(params[:id].to_i)
		# if player.eql?(params[:token])
		# 	result = {:code => 1, :player => player.summary}
		# else
		# 	result = {:code => 0}
		# end
		# if params[:id].to_i == 52
		# 	result = {:code => 1, :player => Player.find(52).summary}
		# end
		result = {:code => 1, :player => Player.find(params[:id]).summary}
		render :json => result
	end
	
	private
	def login_params
		params.permit(:name, :password)
	end
	def verify_params
		params.permit(:id, :token)
	end
end
