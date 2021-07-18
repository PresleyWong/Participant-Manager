class HomeController < ApplicationController
  layout "admin", only: [:dashboard]

  def index
  end
  

  def dashboard
  end

end
