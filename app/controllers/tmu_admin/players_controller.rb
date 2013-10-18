module TmuAdmin
  class PlayersController < TmuAdmin::TmuAdminController
    layout "tmu_admin/layouts/application"

    def index
    end

    def data
      condition = "1=1"
      total = Player.where(condition).count
      players = Player.where(condition).paginate(:page => params[:page]||1, :per_page => params[:rows]||20)
      data_json = {
        :total => total,
        :rows => players
      }
      render :json => data_json
    end
  end
end