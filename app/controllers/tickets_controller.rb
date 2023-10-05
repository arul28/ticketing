class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  # GET /tickets or /tickets.json
  def index
    if session[:role] == "user"
      @tickets = Ticket.includes(:train).where(["passenger_id = ? or for_passenger_id = ?", session[:user_id], session[:user_id]])
    else
      @tickets = Ticket.includes(:train).all
    end
  end

  # GET /tickets/1 or /tickets/1.json
  def show
    if @ticket
      @passenger = Passenger.find_by(id: @ticket.passenger_id)
      @for_passenger = Passenger.find_by(id: @ticket.for_passenger_id)
    end
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @passengers = Passenger.all.pluck(:name, :id)
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @train = Train.find_by(id:@ticket.train_id)
    @passengers = Passenger.all.pluck(:name, :id)
    if @train.number_of_seats_left < 0
      format.html { redirect_to trains_url, notice: "No more seats left" }
      format.json { head :no_content }
    end
    respond_to do |format|
      if @ticket.save
        seats_left = @train.number_of_seats_left - 1
        if @train.update(number_of_seats_left: seats_left)
          format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
          format.json { render :show, status: :created, location: @ticket }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @ticket.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    @train = Train.find(@ticket.train_id)
    seats_left = @train.number_of_seats_left
    new_seats_left = seats_left + 1
    respond_to do |format|
      if @ticket.update(ticket_params)
        if @train.update(number_of_seats_left: new_seats_left)
          format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
          format.json { render :show, status: :ok, location: @ticket }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @ticket.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find_by(id: params[:id])
      if session[:role] == "user"
        if @ticket
          @passenger = Passenger.find_by(id: @ticket.passenger_id)
          if session[:user_id] != @passenger.id
            redirect_to passenger_dashboard_index_path
            return
          end
        else
          redirect_to passenger_dashboard_index_path
          return
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:confirmation_number, :passenger_id, :train_id, :status, :for_passenger_id)
    end
end
