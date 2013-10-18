include TmuAdminHelper
module TmuAdmin
	$ACCESS_LEVEL_ADMIN = 0
	$ACCESS_LEVEL_USER = 10
	class User < ActiveRecord::Base
		self.table_name = "tmu_admin_users"
		acts_as_authentic { |c| c.validate_email_field = false }

		attr_accessor :notify_of_new_password
		after_create :send_create_notification
		after_update :send_update_notification


		def send_create_notification
			TmuAdmin::Notification.new_user_information(email_address, self, hostname, @password).deliver
		end

		def send_update_notification
			if notify_of_new_password
				notify_of_new_password = false
				TmuAdmin::Notification.generate_new_password(email_address, self, hostname, @password).deliver
			end
		end

		def send_password_reset_instructions
			reset_perishable_token!
			TmuAdmin::Notification.password_reset_instructions(email_address, self, hostname).deliver
		end
		def is_admin?
			access_level == $ACCESS_LEVEL_ADMIN
		end

	end
end
