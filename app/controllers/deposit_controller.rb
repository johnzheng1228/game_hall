require 'net/http'

class DepositController < ApplicationController
	def cash
		player_id = params[:id]
		value = params[:value]
		player_wealth = Wealth.find_by_player_id(player_id)
		if player_wealth
			player_wealth.update_attribute(:diamond, (player_wealth.diamond + value))
		end

		uri = URI("http://johnzheng-pc:8080/TMuZJHServer/deposit")
		res = Net::HTTP.post_form(uri, :id => player_id, :diamond => value)
		render :json => {:code => 1}
	end
end
