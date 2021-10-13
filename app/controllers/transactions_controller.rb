class TransactionsController < ApplicationController
  before_action:redirect_to_admin_if_not_logged_in,
  

  def create
    @transaction = Transaction.create(params.require(:transaction).permit(:description,:transactionType,:amount,:account_id))
    thisAccount = Account.find(params[:transaction][:account_id])
    thisAccount.amount = (params[:transaction][:transactionType] == "Deposit")? thisAccount.amount + params[:transaction][:amount].to_i : thisAccount.amount - params[:transaction][:amount].to_i
    @transaction.save
    thisAccount.save
    redirect_to '/admin/panel/user/' + params[:transaction][:user1_id] + "/"+ params[:transaction][:account_id]
  end
  
  def delete
    transaction = Transaction.find(params[:transaction_id])
    thisAccount = Account.find(params[:account_id])
    thisAccount.amount = (transaction.transactionType == "Deposit")? thisAccount.amount - transaction.amount.to_i : thisAccount.amount + transaction.amount.to_i
    thisAccount.save
    transaction.destroy
    redirect_to '/admin/panel/user/' + params[:id] + "/" + thisAccount.id.to_s
  end

  private 
  def redirect_to_admin_if_not_logged_in
    if !helpers.admin_logged_in?
       redirect_to '/admin'
    end
 end

end
