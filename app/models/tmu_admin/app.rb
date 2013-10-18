include TmuAdminHelper
module TmuAdmin
  class App < ActiveRecord::Base
    def summary
      {
        :appid => id,
        :appName => name,
        :icon => image_url,
        :url => package_url,
        :ip => "192.168.0.6",
        :port => 6002
      }
    end

    def package_url
      "#{hostname}/download/package?pid=#{Digest::MD5::hexdigest(Time.now.to_s)}#{id}"
    end

    def image_url
      "#{hostname}/download/image?pid=#{Digest::MD5::hexdigest(Time.now.to_s)}#{id}"
    end
  end
end
