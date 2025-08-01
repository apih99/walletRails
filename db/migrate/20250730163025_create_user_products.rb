class CreateUserProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_products do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end

    add_index :user_products, [:user_id, :product_id], unique: true
  end
end