class AccountsController < ApplicationController
  before_action:redirect_to_admin_if_not_logged_in
  def new
    @account = Account.new
  end

  def create
    @account = Account.create(params.require(:account).permit(:account_number,:user1_id,:amount,:currency))
    
    @transaction = Transaction.new(description:"First Deposit",transactionType:"Deposit",amount:@account.amount,account_id:@account.id)
    @transaction.save
    @account.save
    redirect_to '/admin/panel/user/' + params[:account][:user1_id]
  end

  def admin_view
    @user = User1.find(params[:id])
    @accounts = Account.find(params[:account_id])
    @transactions = Transaction.where(account_id:@accounts.id)
  end

  def delete
    @account = Account.find(params[:account_id]) 
    Transaction.where(account_id: @account.id).destroy_all
    @account.destroy                              
    redirect_to  '/admin/panel/user/' + params[:id] 
end

  private
  def redirect_to_admin_if_not_logged_in
     if !helpers.admin_logged_in?
        redirect_to '/admin'
    end
  end
end
