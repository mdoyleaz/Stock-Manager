class Portfolio < ApplicationRecord
  has_one :user
  has_many :investments, :foreign_key => "portfolio_id"
end
