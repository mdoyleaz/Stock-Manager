class CreateInvestments < ActiveRecord::Migration[5.2]
  def change
    create_table :investments do |t|
      t.integer :shares
      t.float :initial_cost
      t.references :stock, index:true

      t.timestamps
    end
  end
end
