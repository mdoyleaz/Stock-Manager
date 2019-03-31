class Portfolio < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :investments, :foreign_key => "portfolio_id"
end
