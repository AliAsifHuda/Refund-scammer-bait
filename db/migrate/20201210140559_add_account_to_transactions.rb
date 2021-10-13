class AddAccountToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :account
  end
end
