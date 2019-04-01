class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios do |t|
      t.float :total_investment, :default => 0
      t.timestamps
    end
  end
end
