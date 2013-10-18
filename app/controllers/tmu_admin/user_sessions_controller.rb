module TmuAdmin
	class UserSessionsController < TmuAdmin::TmuAdminController
		#unloadable

		skip_before_filter :authorise, :only => [:new, :create]
		before_filter :requires_no_session_user, :except => [:destroy]

		layout "tmu_admin/layouts/login"

		def new
			@user_session = TmuAdmin::UserSession.new
		end

		def create
			@user_session = TmuAdmin::UserSession.new params[:tmu_admin_user_session]
			if @user_session.save
				flash[:notice] = "Login successful"
				redirect_back_or_default(:controller => :tmu_admin, :action => :dashboard)
			else
				render :action => :new
			end
		end

		def destroy
			current_user_session.destroy
			flash[:notice] = "Logout successful"
			redirect_back_or_default new_tmu_admin_user_session_url
		end

		private

		def requires_no_session_user
			if current_user
				redirect_to :controller => :tmu_admin, :action => :index
			end
		end
	end
end
