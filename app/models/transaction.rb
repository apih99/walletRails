class Transaction < ApplicationRecord
  belongs_to :user
  
  belongs_to :transactionable, polymorphic: true, optional: true

  validates :action, presence: true, inclusion: { in: %w(purchase top-up) }
  validates :amount, numericality: { greater_than: 0 }
end