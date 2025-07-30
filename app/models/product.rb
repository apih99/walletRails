class Product < ApplicationRecord
    has_many :transactions, as: :transactionable, dependent: :nullify

    validates :name, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0}
end
