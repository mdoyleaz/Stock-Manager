module PortfoliosHelper
  # Helper that is called from the view to receive the current stock information from the API
  def get_stock_price(symbol = nil)
    ep = 'https://www.worldtradingdata.com/api/v1/stock?symbol=%s&api_token=' << ENV['STOCK_API_TOKEN']

    stock_hash = {}

    if !symbol
      response = query_symbols.map { |symbols| JSON.parse(HTTParty.get(ep % symbols).body)['data'] }.flatten
      response.map { |res| stock_hash[res['symbol']] = res }
    else
      hashed_response[symbol] = JSON.parse(HTTParty.get(ep % symbol).body)['data']
    end

    stock_hash
  end

  # Queries the symbols from the investments table
  def query_symbols
    symbols_query = @portfolio.investments.map { |investment| investment.stock.symbol }

    if symbols_query.length > 5
      symbols_sliced = symbols_query.each_slice(5).to_a
      symbols = symbols_sliced.map { |sym| [sym.join(',')] }
    else
      symbols = [symbols_arr.join(',')]
    end
    symbols
  end

  # Performs caluclations for earnings based on current share price
  def calculate_earnings(shares, purchase_value, current_value)
    earnings = (shares * current_value.to_i) - (shares * purchase_value)

    if earnings > 0
      "+$#{earnings.abs}"
    else
      "-$#{earnings.abs}"
    end

  end
end
