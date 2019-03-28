# Building The Database

I created a table to hold all of the stocks and the endpoints to access these. These will be able to be added to a portfolio for a customer.

## Stocks

To start I built a scaffold to manage `Stocks` with the following roles:

-   name -> String
-   symbol -> String
-   exchange -> string
-   endpoint -> String

These are going to store the specific stocks and API endpoints, these will later be assigned to the users portfolio table.

#### Building the scaffold

```bash
$ docker-compose run rails rails g scaffold Stock name:string symbol:string exchange:string endpoint:string

$ docker-compose run rails rake db:migrate
```

#### Creating initial seeds

I created a quick function to generate the initial stock seeds, I chose the top 20 tech stocks to add here and pulled the details from the `worldtradingdata.com` API.

I decdied to `HTTParty` for my HTTP requests, vs' the one included with rails, simply because the syntax is easier to use, and will make it easier to work with later on in the project.

```ruby
# Create Initial Stocks
def parse_stocks(response, endpoint)
  JSON.parse(response.body)['data'].each do |res|
    Stock.create('name': res['name'], 'symbol': res['symbol'], 'exchange': res['stock_exchange_short'], 'endpoint': endpoint % res['symbol'])
  end
end

stock_symbols = ['AAPL', 'MSFT', 'TWTR', 'NFLX', 'HEAR',
                 'P', 'AMD', 'AAXN', 'AMZN', 'PANW',
                 'ADBE', 'TRIP', 'NTAP', 'EA', 'TTD',
                 'DDD', 'I', 'IQ', 'HUYA', 'MOMO', 'TWLO,CRM']

stock_symbols.each_slice(5).to_a.each do |symbols|
  ep = 'https://www.worldtradingdata.com/api/v1/stock?symbol=%s&api_token='
  res = HTTParty.get(ep % symbols.join(',') << ENV['STOCK_API_TOKEN'])
  parse_stocks(res, ep)
end
```

## Portfolio

For the `Portfolio` table I created this with two relations `User` and `Stocks`. The idea is that a user is linked to a portfolio, which contains individual stocks from the `Stock` table.

To start I will build a migration to manage `Stocks` with the following items:

-   user_id -> One to one with User
-   stock_id -> One-to-Many with Stock
-   total_investments -> Integer

I didn't plan on this, but now that I am here I think that creating one more table may be ideal to store the number of shares purchased and cost of each share in another table.

#### Building the table

```bash
docker-compose run rails rails g migration CreatePortfolio
```
