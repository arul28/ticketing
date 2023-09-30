class UsersController < ApplicationController
  def new
  end

  def create
    @user = Passenger.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:role] = "user"
      redirect_to passenger_path(@user), notice: "Logged in successfully!"
    else
      flash.now[:alert] = "Invalid login credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
