class AddInvestmentsIdToPortfolio < ActiveRecord::Migration[5.2]
  def change
    add_reference :portfolios, :investments, foreign_key: true, on_delete: :cascade
  end
end
