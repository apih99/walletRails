class AllowNullOnTransactionableInTransactions < ActiveRecord::Migration[8.0]
  def change
    change_column_null :transactions, :transactionable_type, true
    change_column_null :transactions, :transactionable_id, true
  end
end
