class PassengerDashboardController < ApplicationController
  def index
    #@passenger = Passenger.find(session[:user_id])

    if session[:user_id] && Passenger.exists?(session[:user_id])
      @passenger = Passenger.find(session[:user_id])
    else
      redirect_to userlogin_path, alert: "Please log in first."
    end

  end

end
