class SessionsController < ApplicationController
#include SessionsHelper
  def new
  end

  def create
    user = User1.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in (user)
      redirect_to visitors_path
      #redirect user to redirection
    else
    flash.now[:danger]= "No valid credentials were provided"
      #add error message
    render 'new'
  end
end

  def destroy
  end
  def logout
    session.delete(:user_id)
    redirect_to '/'
  end
  def index
  end

end
