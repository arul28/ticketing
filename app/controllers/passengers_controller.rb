class PassengersController < ApplicationController
  before_action :set_passenger, only: %i[ show edit update ]
  
  # GET /passengers or /passengers.json
  def index
    if session[:role] == "user"
      redirect_to passenger_dashboard_index_path
    end
    @passengers = Passenger.all
    @passengers = Passenger.where(id: params[:id]) if params[:id].present?
  end

  # GET /passengers/1 or /passengers/1.json
  def show
  end

  # GET /passengers/new
  def new
    @passenger = Passenger.new
  end

  # GET /passengers/1/edit
  def edit
  end

  # POST /passengers or /passengers.json
  def create
    @passenger = Passenger.new(passenger_params)

    respond_to do |format|
      if @passenger.save
        format.html { redirect_to userlogin_path, notice: "Passenger was successfully created." }
        format.json { render :show, status: :created, location: @passenger }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /passengers/1 or /passengers/1.json
  def update
    respond_to do |format|
      if @passenger.update(passenger_params)
        format.html { redirect_to passenger_url(@passenger), notice: "Passenger was successfully updated." }
        format.json { render :show, status: :ok, location: @passenger }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /passengers/1 or /passengers/1.json
  def destroy
    @passenger = Passenger.find_by(id: params[:id])
    @passenger.destroy
    respond_to do |format|
      if session[:role] == "user"
        session[:role] = nil
        session[:user_id] = nil
        format.html { redirect_to root_path, notice: "Passenger was successfully destroyed." }
        format.json { head :no_content }
      end
      format.html { redirect_to passengers_url, notice: "Passenger was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_passenger
      if session[:role] == "user"
        if session[:user_id] != params[:id].to_i
          redirect_to passenger_dashboard_index_path
          return
        end
      end
      @passenger = Passenger.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def passenger_params
      params.require(:passenger).permit(:name, :email, :password, :phone_number, :address, :credit_card)
    end
end
