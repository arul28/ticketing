class LandingPageController < ApplicationController
  def index
    if session[:role]
      if session[:role] == "admin"
        redirect_to admin_dashboard_index_path
      elsif session[:role] == "user"
        redirect_to passenger_dashboard_index_path
      end
    end
  end
end
