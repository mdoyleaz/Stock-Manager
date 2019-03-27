json.extract! stock, :id, :name, :symbol, :exchange, :endpoint, :created_at, :updated_at
json.url stock_url(stock, format: :json)
