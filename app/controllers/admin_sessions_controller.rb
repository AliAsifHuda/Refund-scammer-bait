class AdminSessionsController < ApplicationController
   before_action:redirect_to_admin_if_not_logged_in, only: [:adminPanel]

  def new
  end

  def create
    @admin_user = AdminUser.find_by(username: params[:username])
    if @admin_user && @admin_user.authenticate(params[:password])
       session[:admin_id] = @admin_user.id
       redirect_to '/admin/panel'
    else
      redirect_to'/admin'
    end
 end

  def adminLogin
  end

  def adminPage
      if helpers.admin_logged_in?
         redirect_to '/admin/panel'
      end
  end

  def adminLogout
   if helpers.admin_logged_in?
      session.delete(:admin_id)
   end
   redirect_to '/admin'
  end
  def adminPanel
    @site_users = User1.find_each
  end
  private 
    def redirect_to_admin_if_not_logged_in
      if !helpers.admin_logged_in?
         redirect_to '/admin'
      end
   end

end
