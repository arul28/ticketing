class AdminDashboardController < ApplicationController
  def index
    if session[:admin_id] && Admin.exists?(session[:admin_id])
      @admin = Admin.find(session[:admin_id])
    else
      redirect_to landing_page_index_path, alert: "Please log in first."
    end
  end
end
