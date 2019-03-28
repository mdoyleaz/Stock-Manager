class AddIndexToStocks < ActiveRecord::Migration[5.2]
  def change
    add_index :stocks, :symbol
  end
end
