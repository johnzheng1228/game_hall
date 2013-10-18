module TmuAdmin
  class ActiveDevicesController < TmuAdmin::TmuAdminController
   layout "tmu_admin/layouts/application"
   layout "tmu_admin/layouts/application"

   before_action :set_active_device, only: [:show, :destroy]
   def index
   end

   def data
    condition = "1=1"
    total = ActiveDevice.where(condition).count
    devices = ActiveDevice.where(condition).paginate(:page => params[:page]||1, :per_page => params[:rows]||20)
    data_json = {
      :total => total,
      :rows => devices
    }
    render :json => data_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_active_device
      @active_device = ActiveDevice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def active_device_params
      params.require(:active_device).permit(:device, :serail)
    end
  end
end
