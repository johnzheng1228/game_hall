class AppsController < ApplicationController
  def list
    apps = TmuAdmin::App.all
    app_array = []
    apps_json = {}
    apps.each { |app_info|
      app_array << app_info.summary
    }
    apps_json[:apps] = app_array
    render :json => apps_json
  end

  def rooms
    rooms = TmuAdmin::Room.where(:appid => params[:appid])
    room_array = []
    room_json = {}
    rooms.each { |room|
      room_array << room.summary
    }
    room_json[:rooms] = room_array
    render :json => room_json
  end
end
