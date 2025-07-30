class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action
      t.decimal :amount
      t.references :transactionable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
