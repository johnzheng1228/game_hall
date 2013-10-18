module TmuAdmin
	class TmuAdminController < ApplicationController
		unloadable

		layout "tmu_admin/layouts/main"

		before_filter :authorise

		def index		
			redirect_to dashboard_url
		end

		def dashboard
			@tmu_admin_page_title = "首页"
      #render :json => {}
		end

		private
		def authorise    
			unless current_user
				session[:return_to] = request.fullpath
				redirect_to new_tmu_admin_user_session_url
				return false
			end
		end

		def current_user_session
			return @current_user_session if defined?(@current_user_session)
			@current_user_session = TmuAdmin::UserSession.find
		end

		def current_user
			return @session_user if defined?(@session_user)
			@session_user = current_user_session && current_user_session.user
		end

		def needs_admin
			unless @session_user.is_admin?
				redirect_to :controller => :tmu_admin, :action => :index
			end
		end


		def redirect_back_or_default(default)
			redirect_to(session[:return_to] || default)
			session[:return_to] = nil
		end
	end
end
