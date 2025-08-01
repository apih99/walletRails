class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions, dependent: :destroy
  has_many :user_products, dependent: :destroy
  has_many :owned_products, through: :user_products, source: :product
  
  validates :credit, numericality: { greater_than_or_equal_to: 0}
end
