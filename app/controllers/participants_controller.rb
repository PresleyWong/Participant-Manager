class ParticipantsController < ApplicationController
  before_action :set_participant, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :set_layout
  # layout "dashboard"

  def set_layout
    if current_admin
      self.class.layout "dashboard"
    else
      self.class.layout "dashboard_server"
    end
  end

  # GET /participants or /participants.json
  def index
    if server_signed_in?
      @participants = Participant.where(:locality => current_server.locality).order(params[:sort])
    else
      @participants = Participant.order(params[:sort])
    end
  end

  def export
    @participants = Event.find(params[:event_id]).participants
    respond_to do |format|
      format.csv { send_data @participants.to_csv, filename: "participants-#{DateTime.now.strftime("%d-%m-%Y%_I%M%p")}.csv" }
    end
  end

  def import
    event = Event.find(params[:event_id])
    Participant.import(params[:file], event)    
    redirect_to event_path(event), notice: "Participant imported!"
  end

  # GET /participants/1 or /participants/1.json
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants or /participants.json
  def create
    @participant = Participant.new(participant_params)

    if server_signed_in?
      @participant.locality = current_server.locality
    end

    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: "Participant was successfully created." }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1 or /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to @participant, notice: "Participant was successfully updated." }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1 or /participants/1.json
  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url, notice: "Participant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.require(:participant).permit(:gender, :english_name, :chinese_name, :email, :phone, :college, :academic_year, :language, :remarks, :locality)
    end
end
