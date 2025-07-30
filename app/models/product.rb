class Product < ApplicationRecord
    has_many :transactions, as: :transactionable, dependent: :nullify
    has_many :user_products, dependent: :destroy
    has_many :owners, through: :user_products, source: :user


    validates :name, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0}
end
