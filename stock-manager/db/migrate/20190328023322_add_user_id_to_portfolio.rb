class AddUserIdToPortfolio < ActiveRecord::Migration[5.2]
  def change
    add_column :portfolios, :user_id, :integer
  end
end
