class TrainsController < ApplicationController
  before_action :set_train, only: %i[ show edit update destroy ]

  # GET /trains or /trains.json
  def index
    @departure_stations = Train.select(:departure_station).distinct.pluck(:departure_station)
    @termination_stations = Train.select(:termination_station).distinct.pluck(:termination_station)
    @departure_dates = Train.select(:departure_date).distinct.pluck(:departure_date)
    @ratings = ["Yes"]
    @upcoming = ["Yes"]
    @searchf = Train.pluck(:train_number)

    @trains = Train.all
    @trains = @trains.where(departure_station: params[:departure_station]) if params[:departure_station].present?
    @trains = @trains.where(termination_station: params[:termination_station]) if params[:termination_station].present?
    @trains = @trains.where(departure_date: params[:departure_date]) if params[:departure_date].present?
    @trains = @trains.joins(:reviews).where('reviews.rating >= ?', 3).distinct if params[:rating] == "Yes"
    @trains = @trains.where('number_of_seats_left > ?', 0).where('departure_date > ?', Date.today()) if params[:upcoming] == "Yes"
    if params[:searchf].present?
      @ids = Train.joins(:tickets).includes(:passengers).distinct.pluck("passengers.id")
      redirect_to passengers_path(id: @ids)
    end
   
  end
  

  # GET /trains/1 or /trains/1.json
  def show
  end

  # GET /trains/new
  def new
    @train = Train.new
  end

  # GET /trains/1/edit
  def edit
  end

  # POST /trains or /trains.json
  def create
    @train = Train.new(train_params)

    respond_to do |format|
      if @train.save
        format.html { redirect_to train_url(@train), notice: "Train was successfully created." }
        format.json { render :show, status: :created, location: @train }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @train.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trains/1 or /trains/1.json
  def update
    respond_to do |format|
      if @train.update(train_params)
        format.html { redirect_to train_url(@train), notice: "Train was successfully updated." }
        format.json { render :show, status: :ok, location: @train }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @train.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trains/1 or /trains/1.json
  def destroy
    @train.destroy

    respond_to do |format|
      format.html { redirect_to trains_url, notice: "Train was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_train
      @train = Train.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def train_params
      params.require(:train).permit(:train_number, :departure_station, :termination_station, :departure_date, :departure_time, :arrival_date, :arrival_time, :ticket_price, :train_capacity, :number_of_seats_left)
    end
end
