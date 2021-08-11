class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  layout "dashboard"

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
    if query_params.empty?
      @participants = Participant.none
    else
      @participants = Participant.filtered(query_params)
    end

    registrants = Array.new  
    appointments = Array.new  
    @event.appointments.each do |a|
      registrants << Participant.find(a.participant_id)
      appointments << a
    end

    @regis = registrants.zip(appointments) 
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  def register_participant
    Appointment.create(participant_id: params[:participant_id], event_id: params[:event_id], server_name: "testing server")
    redirect_to event_path(params[:event_id])
  end

  def remove_participant
    Appointment.where(participant_id: params[:participant_id], event_id: params[:event_id]).destroy_all
    redirect_to event_path(params[:event_id])
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :date, :start_time, :end_time)
    end

    def query_params
      query_params = params[:query]
      query_params ? query_params.permit(:search_item) : {}
    end
end
