module Activable
	extend ActiveSupport::Concern

	def generate_serial_number(device_id)
		serial_number_md5 = Digest::MD5.hexdigest("--MD5--#{device_id}#{Time.now.to_i}")
		ActiveDevice.create(:device => device_id,:serial => serial_number_md5)
		serial_number_md5
	end
end