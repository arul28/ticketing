class PassengerDashboardController < ApplicationController
  def index
    @passenger = Passenger.find(session[:user_id])
  end
end
