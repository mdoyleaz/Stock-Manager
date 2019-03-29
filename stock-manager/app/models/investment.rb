class Investment < ApplicationRecord
  belongs_to :portfolio, :foreign_key => "portfolio_id"
  has_one :stock
end
