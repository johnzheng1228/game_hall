class DownloadController < ApplicationController
  $ENCODE_STR_LENGT = 32

  def package
    package_id = params[:pid]
    appid = package_id[$ENCODE_STR_LENGT, package_id.length]
    app = TmuAdmin::App.find(appid)
    send_file("#{Rails.root}#{app.url}")
  end

  def image
    package_id = params[:pid]
    appid = package_id[$ENCODE_STR_LENGT, package_id.length]
    app = TmuAdmin::App.find(appid)
    send_file("#{Rails.root}#{app.icon}")
  end

end
