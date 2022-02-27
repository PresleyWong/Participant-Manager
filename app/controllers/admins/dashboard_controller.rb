class Admins::DashboardController < ApplicationController
  layout "dashboard"
  before_action :set_server, only: %i[ edit_server update_server destroy_server ]

  def index
  end

  def servers
    @servers = Server.order(params[:sort])
  end

  def new_server
    @server = Server.new
  end

  def edit_server
  end

  def create_server
    @server = Server.new(email: params[:email], password: params[:password], locality: params[:locality])

    respond_to do |format|
      if @server.save
        format.html { redirect_to admins_servers_path, notice: "sSrver was successfully created." }
        format.json { render :show, status: :created, location: @server }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_server
    respond_to do |format|
      if @server.update(server_params)
        format.html { redirect_to admins_servers_path, notice: "Server was successfully updated." }
        format.json { render :show, status: :ok, location: @server }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_server
    @server.destroy
    respond_to do |format|
      format.html { redirect_to admins_servers_path, notice: "Server was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_server
    @server = Server.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def server_params
    params.require(:server).permit(:email, :password, :locality)
  end

end
