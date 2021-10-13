class Transaction < ApplicationRecord
  belongs_to :account

  validates :description, presence: true, length: { minimum: 2 }
  validates :transactionType, presence: true , inclusion: { in: %w(Withdrawal Deposit)}
  validates :amount, presence: true
end
