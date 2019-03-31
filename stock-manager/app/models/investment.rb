class Investment < ApplicationRecord
  belongs_to :portfolio, :foreign_key => "portfolio_id"
  belongs_to :stock
end
