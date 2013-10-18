module TmuAdmin

  class Notification < ActionMailer::Base

  	self.prepend_view_path File.join(File.dirname(__FILE__), '..', 'views', 'tmu_admin')

  	def generate_new_password from, tmu_admin_user, host, pass
  		@name = tmu_admin_user.name
  		@host = host
  		@login = tmu_admin_user.login
  		@pass = pass
  		@from_text = website_name
  		
  		mail(:to => tmu_admin_user.email, :from => from, :subject => "[#{website_name}] New password")
  	end

  	def new_user_information from, tmu_admin_user, host, pass
      @name = tmu_admin_user.name
      @host = host
      @login = tmu_admin_user.login
      @pass = pass
      @from_text = website_name

      mail(:to => tmu_admin_user.email, :from => from, :subject => "[#{website_name}] New user account")
    end

    def password_reset_instructions from, tmu_admin_user, host
     ActionMailer::Base.default_url_options[:host] = host.gsub("http://", "")
     @name = tmu_admin_user.name
     @host = host
     @login = tmu_admin_user.login
     @reset_password_url = edit_tmu_admin_password_reset_url + "/?token=#{tmu_admin_user.perishable_token}"
     @from_text = website_name

     mail(:to => tmu_admin_user.email, :from => from, :subject => "[#{website_name}] Password reset instructions")
   end

 end
end