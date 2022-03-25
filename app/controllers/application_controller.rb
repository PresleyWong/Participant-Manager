class ApplicationController < ActionController::Base
    def authenticate_user!
        if admin_signed_in? or server_signed_in?
            #able to proceed
        else	  		
            redirect_to main_app.root_path
        end
    end

    def authenticate_admin!
        if admin_signed_in?
            #able to proceed
        else	  		
            redirect_to main_app.root_path
        end
    end
end
