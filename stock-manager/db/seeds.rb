# Create initial user
port1 = Portfolio.create()
port2 = Portfolio.create()
User.create(email: 'manager@test.com', password: 'password', manager: true, portfolio: port1)
User.create(email: 'customer@test.com', password: 'password', manager: false, portfolio: port2)

# # Create Initial Stocks
def parse_stocks(response, endpoint)
  JSON.parse(response.body)['data'].each do |res|
    puts Stock.create('name': res['name'], 'symbol': res['symbol'], 'exchange': res['stock_exchange_short'], 'endpoint': endpoint % res['symbol'])
  end
end

stock_symbols = ['AAPL', 'MSFT', 'TWTR', 'NFLX', 'HEAR',
                 'P', 'AMD', 'AAXN', 'AMZN', 'PANW',
                 'ADBE', 'TRIP', 'NTAP', 'EA', 'TTD',
                 'DDD', 'I', 'IQ', 'HUYA', 'MOMO', 'TWLO', 'CRM']

stock_symbols.each_slice(5).to_a.each do |symbols|
  ep = 'https://www.worldtradingdata.com/api/v1/stock?symbol=%s&api_token='
  res = HTTParty.get(ep % symbols.join(',') << ENV['STOCK_API_TOKEN'])
  parse_stocks(res, ep)
end
