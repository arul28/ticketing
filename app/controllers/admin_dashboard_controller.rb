class AdminDashboardController < ApplicationController
  def index
    @admin = Admin.find(session[:admin_id])
  end
end
