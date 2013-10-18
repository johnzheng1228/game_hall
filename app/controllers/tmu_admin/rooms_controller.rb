module TmuAdmin
  class RoomsController < TmuAdmin::TmuAdminController
    before_action :set_room, only: [:show, :edit, :update, :destroy]
    layout "tmu_admin/layouts/application"
    
    def index
      @appid = params[:app]||0
      @apps = TmuAdmin::App.all
    end


    def data
      condition = "appid = #{params[:app]}"
      total = TmuAdmin::Room.where(condition).count
      rooms = TmuAdmin::Room.where(condition).paginate(:page => params[:page]||1, :per_page => params[:rows]||20)
      data_json = {
        :total => total,
        :rows => rooms
      }
      render :json => data_json
    end

    def search
      redirect_to :action => :index,:app => params[:app]
    end

    def show
    end

    def new
      @room = TmuAdmin::Room.new
      @apps = TmuAdmin::App.all
    end

    # GET /rooms/1/edit
    def edit
    end

    # POST /rooms
    # POST /rooms.json
    def create
      @room = TmuAdmin::Room.new(room_params)

      if @room.save
        render :json => {}
      else
        error_messages = @room.errors.full_messages.collect { |error_message| "<li>" + error_message + "</li>" }

        render :json => {:errorMsg => "<ul>" + error_messages.join("") + "</ul>"}
      end
    end

    # PATCH/PUT /rooms/1
    # PATCH/PUT /rooms/1.json
    def update
      respond_to do |format|
        if @room.update(room_params)
          format.html { redirect_to @room, notice: 'Room was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /rooms/1
    # DELETE /rooms/1.json
    def destroy
      @room.destroy
      respond_to do |format|
        format.html { redirect_to rooms_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = TmuAdmin::Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:appid,:name,:backgroud,:total_lest,:single_lest)
    end
  end
end
