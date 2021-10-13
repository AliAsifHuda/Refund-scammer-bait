class AddForeignKeyToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :transactions, :accounts
  end
end
