class AddPortfolioToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :portfolio_id, :integer
  end
end
