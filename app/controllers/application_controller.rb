class ApplicationController < ActionController::Base
    before_action :check_login


    def check_login
        if !session[:role].present?
            if !request.path.in?([landing_page_index_path, login_path, userlogin_path, landing_path, new_passenger_path, passengers_path])
                redirect_to landing_page_index_path, notice: "Please log in first."
            end
        end
    end
end
