class UserController < ApplicationController
    before_action:redirect_to_admin_if_not_logged_in
   
    def new
        @user = User1.new  
    end
    
    def create
        @user = User1.create(params.require(:user1).permit(:username,:password))
        redirect_to '/admin/panel'
    end

    def delete
        @accounts = Account.where(user1_id: params[:user_id]) # get accounts for this user
        @accounts.each do |a|                                 # for account belonging to this user delete all the transactions
            Transaction.where(account_id: a.id).destroy_all
         end
        @accounts.destroy_all                                 # delete all the accounts
        User1.find(params[:user_id]).destroy;                 # delete the user
        redirect_to  '/admin/panel'
      
    end
    
    def show
        @user = User1.find(params[:id])
  
    end
 
    private 
    def redirect_to_admin_if_not_logged_in
       if !helpers.admin_logged_in?
          redirect_to '/admin'
      end
    end
end
