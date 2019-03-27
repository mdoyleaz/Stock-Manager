class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :symbol
      t.string :exchange
      t.string :endpoint

      t.timestamps
    end
  end
end
