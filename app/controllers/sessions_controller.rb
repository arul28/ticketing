class SessionsController < ApplicationController
  def new
    if session[:role].present?
      if session[:role] == "admin"
        redirect_to admin_dashboard_index_path
      else
        redirect_to passenger_dashboard_index_path
      end
    end
  end

  def create
    admin = Admin.find_by(username: params[:username])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      session[:role] = "admin"
      redirect_to admin_dashboard_index_path, notice: "Logged in successfully!"
    else
      flash.now[:alert] = "Invalid login credentials"
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    session[:role] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
