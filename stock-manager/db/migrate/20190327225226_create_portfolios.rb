class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios do |t|
      t.float :total_investment

      t.timestamps
    end
  end
end
