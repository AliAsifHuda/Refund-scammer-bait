module AdminSessionsHelper
    def hasAdminUser
        AdminUser.any? 
    end
    def current_admin_user
        AdminUser.find_by(id: session[:admin_id])
    end


    def admin_logged_in?
        !current_admin_user.nil?
    end
end
