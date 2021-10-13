class RemoveUserIdFromAccounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :user_id, :string
  end
end
