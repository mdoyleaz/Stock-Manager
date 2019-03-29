class AddPortfolioIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :portfolio, foreign_key: true, on_delete: :cascade
  end
end
