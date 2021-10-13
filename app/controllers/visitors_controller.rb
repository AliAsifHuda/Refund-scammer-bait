class VisitorsController < ApplicationController
  before_action:redirect_to_root_if_not_logged_in
  def index
    
  end


  def transactions
  
    @accounts = Account.find(params[:account_id])
    @transactions = Transaction.where(account_id:@accounts.id)
    
  end

  def new_transaction
  end

  def create_new_transaction 
    thisAccount = Account.find(params[:account_id])
    if (params[:transaction][:amount].to_i <= 0)
        flash[:notice] = "You need to enter a valid  amount for the transaction"
        redirect_to  '/visitors/'+ params[:transaction][:account_id] +'/new_transaction'
    elsif !((thisAccount.amount - params[:transaction][:amount].to_i) < 0)
      @transaction = Transaction.create(params.require(:transaction).permit(:description,:amount,:account_id,:transactionType))
      thisAccount.amount = thisAccount.amount - params[:transaction][:amount].to_i
      @transaction.save
      thisAccount.save
      redirect_to '/visitors/'+ params[:transaction][:account_id] +'/transactions'
    else
    flash[:notice] = "You do not have enough money in you're account to make this transaction"
    redirect_to  '/visitors/'+ params[:transaction][:account_id] +'/new_transaction'
    end
  end

  private 
    def redirect_to_root_if_not_logged_in
      if !helpers.logged_in?
         redirect_to '/'
      end
   end


end
