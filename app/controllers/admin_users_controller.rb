class AdminUsersController < ApplicationController

  def new
    if !AdminUser.any?
      @user = AdminUser.new
    elsif !helpers.admin_logged_in?
      redirect_to '/admin'
    else
      @user = AdminUser.new
    end
    
  end

  

  def create
    @user = AdminUser.create(params.require(:admin_user).permit(:username,:password))
    redirect_to '/admin'
 end
end
