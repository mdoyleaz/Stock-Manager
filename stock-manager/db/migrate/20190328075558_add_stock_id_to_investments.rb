class AddStockIdToInvestments < ActiveRecord::Migration[5.2]
  def change
    add_reference :investments, :stock, foreign_key: true
  end
end
