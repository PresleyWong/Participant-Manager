class HomeController < ApplicationController
  def index
    if admin_signed_in?
      redirect_to(admins_authenticated_root_path)
    elsif server_signed_in?
      redirect_to(servers_authenticated_root_path)
    end

    @events = Event.order(start_date: :desc)
  end

end
