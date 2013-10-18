module TmuAdmin
  class AppsController < TmuAdmin::TmuAdminController
    layout "tmu_admin/layouts/application"

    before_action :set_app, only: [:show, :edit, :update, :destroy]

    # GET /apps
    # GET /apps.json
    def index
    end


    def data
      condition = "1=1"
      total = TmuAdmin::App.where(condition).count
      apps = TmuAdmin::App.where(condition).paginate(:page => params[:page]||1, :per_page => params[:rows]||20)
      data_json = {
          :total => total,
          :rows => apps
      }
      render :json => data_json
    end

    def new
      @app = TmuAdmin::App.new
    end

    # GET /apps/1/edit
    def edit
    end

    # POST /apps
    # POST /apps.json
    def create
      @app = TmuAdmin::App.new(app_params)
      if @app.save
        render :json => {}
      else
        error_messages = @app.errors.full_messages.collect { |error_message| "<li>" + error_message + "</li>" }

        render :json => {:errorMsg => "<ul>" + error_messages.join("") + "</ul>"}
      end
    end

    # PATCH/PUT /apps/1
    # PATCH/PUT /apps/1.json
    def update
      respond_to do |format|
        if @app.update(app_params)
          format.html { redirect_to @app, notice: 'App was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @app.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /apps/1
    # DELETE /apps/1.json
    def destroy
      @app.destroy
      respond_to do |format|
        format.html { redirect_to apps_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = TmuAdmin::App.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      icon_obj = params[:tmu_admin_app][:icon]
      package_obj = params[:tmu_admin_app][:url]

      icon_suffix = icon_obj.original_filename.split(".").last
      package_suffix = package_obj.original_filename.split(".").last

      icon_file_path = "#{Rails.root}/public/images/apk/icons/#{Digest::MD5.hexdigest(Time.now.to_i.to_s)}.#{icon_suffix}"
      package_file_path = "#{Rails.root}/public/files/apk/packages/#{Digest::MD5.hexdigest(Time.now.to_s)}.#{package_suffix}"

      icon_url = "/public/images/apk/icons/#{Digest::MD5.hexdigest(Time.now.to_s)}.#{icon_suffix}"
      package_url = "/public/images/apk/packages/#{Digest::MD5.hexdigest(Time.now.to_s)}.#{package_suffix}"


      FileUtils.mkdir_p File.dirname(icon_file_path) unless File.exists?(icon_file_path)
      FileUtils.mkdir_p File.dirname(package_file_path) unless File.exists?(package_file_path)

      File.open(icon_file_path, "wb") { |icon| icon.write(icon_obj.read) }
      File.open(package_file_path, "wb") { |apk| apk.write(package_obj.read) }

      params[:tmu_admin_app][:icon] = icon_url
      params[:tmu_admin_app][:url] = package_url

      params.require(:tmu_admin_app).permit(:name, :icon, :url)
    end
  end
end