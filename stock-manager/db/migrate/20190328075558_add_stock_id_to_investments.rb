class AddStockIdToInvestments < ActiveRecord::Migration[5.2]
  def change
    add_column :investments, :stock, :integer foreign_key: true
  end
end
