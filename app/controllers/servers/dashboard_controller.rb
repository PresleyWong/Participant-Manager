class Servers::DashboardController < ApplicationController
  # layout "dashboard"
  
  def index
      redirect_to events_path
  end
  
end
