class AddAmountToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :amount, :integer
  end
end
