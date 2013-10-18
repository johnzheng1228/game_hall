module TmuAdmin
	class UsersController < TmuAdmin::TmuAdminController

		  layout "tmu_admin/layouts/application"

		before_filter :needs_admin, :except => [:show, :destroy, :update, :update_password]
		before_filter :needs_admin_or_current_user, :only => [:show, :destroy, :update, :update_password]
		
		def index
		end

		def data
			condition = "1=1"
			total = TmuAdmin::User.where(condition).count
			players = TmuAdmin::User.where(condition).paginate(:page => params[:page]||1, :per_page => params[:rows]||20)
			data_json = {
				:total => total,
				:rows => players
			}
			render :json => data_json
		end
		
		def new
			@casein_user = TmuAdmin::User.new
		end
		
		def create
			@tmu_admin_user = TmuAdmin::User.new casein_user_params
			
			if @tmu_admin_user.save
				flash[:notice] = "An email has been sent to " + @tmu_admin_user.name + " with the new account details"
				redirect_to tmu_admin_users_path
			else
				flash.now[:warning] = "There were problems when trying to create a new user"
				render :action => :new
			end
		end
		
		def show
			@tmu_admin_user = TmuAdmin::User.find params[:id]
		end
		
		def update
			@tmu_admin_user = TmuAdmin::User.find params[:id]

			if @tmu_admin_user.update_attributes tmu_admin_user_params
				flash[:notice] = @tmu_admin_user.name + " has been updated"
			else
				flash.now[:warning] = "There were problems when trying to update this user"
				render :action => :show
				return
			end
			
			if @session_user.is_admin?
				redirect_to tmu_admin_user_users_path
			else
				redirect_to :controller => :tmu_admin, :action => :index
			end
		end
		
		def update_password
			@tmu_admin_user = TmuAdmin::User.find params[:id]
			
			if @tmu_admin_user.valid_password? params[:form_current_password]
				if @tmu_admin_user.update_attributes tmu_admin_user_params
					flash.now[:notice] = "Your password has been changed"
				else
					flash.now[:warning] = "There were problems when trying to change the password"
				end
			else
				flash.now[:warning] = "The current password is incorrect"
			end
			
			render :action => :show
		end
		
		def reset_password
			@tmu_admin_user = TmuAdmin::User.find params[:id]
			
			@tmu_admin_user.notify_of_new_password = true unless @tmu_admin_user.id == @session_user.id
			
			if @tmu_admin_user.update_attributes tmu_admin_user_params
				if @tmu_admin_user.id == @session_user.id
					flash.now[:notice] = "Your password has been reset"
				else    
					flash.now[:notice] = "Password has been reset and " + @tmu_admin_user.name + " has been notified by email"
				end
				
			else
				flash.now[:warning] = "There were problems when trying to reset this user's password"
			end
			render :action => :show
		end
		
		def destroy
			user = TmuAdmin::User.find params[:id]
			if user.is_admin? == false || TmuAdmin::User.has_more_than_one_admin
				user.destroy
				flash[:notice] = user.name + " has been deleted"
			end
			redirect_to casein_users_path
		end

		private

		def tmu_admin_user_params
			params.require(:casein_user).permit(:login, :name, :email, :time_zone, :access_level, :password, :password_confirmation)
		end
	end
end
