class Account < ApplicationRecord
  belongs_to :user1
  has_many :transactions

  validates :account_number,presence: true,uniqueness: { case_sensitive: false},length: { minimum:6,maximum:6},format: { with: /\A[+-]?\d+\z/ }
  
end
