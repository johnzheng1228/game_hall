class ActiveController < ApplicationController
	include Activable
	def device
		device_id = params[:deviceid]
		serial_number = generate_serial_number(device_id)
		render :json => {:serial => serial_number}
	end
end
