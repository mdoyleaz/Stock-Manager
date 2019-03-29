class AddPortfolioIdToInvestments < ActiveRecord::Migration[5.2]
  def change
    add_reference :investments, :portfolio, foreign_key: true, on_delete: :cascade
  end
end
