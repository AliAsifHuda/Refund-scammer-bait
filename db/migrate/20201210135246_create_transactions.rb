class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.date :date
      t.string :description
      t.string :transactionType
      t.decimal :amount

      t.timestamps
    end
  end
end
