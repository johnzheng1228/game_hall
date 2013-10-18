class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authorized!, :except => :new

  def authorized!
    if params[:controller].include?("tmu_admin")
      if false
        redirect_to "/admin/"
      end
    end
  end
end
