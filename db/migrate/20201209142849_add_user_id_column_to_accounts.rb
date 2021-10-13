class AddUserIdColumnToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_reference :accounts, :user1, null: true, foreign_key: true
  end
end
