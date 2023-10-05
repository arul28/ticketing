class UsersController < ApplicationController
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
    @user = Passenger.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:role] = "user"
      redirect_to passenger_dashboard_index_path, notice: "Logged in successfully!"
    else
      flash.now[:alert] = "Invalid login credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:role] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
