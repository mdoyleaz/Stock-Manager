# Building The Database

I created a table to hold all of the stocks and the endpoints to access these. These will be able to be added to a portfolio for a customer.

## Users

For the user table I used devise to perform the initial setup and added a couple of additional migrations to handle a `manager` flag, and the relationship with the Portfolio table.

This table is structured like so

-   email -> String
-   password -> String
-   manager -> Boolean
-   portfolio_id -> Integer - One to one relationship with `Portfolio`

* * *

#### Model

Location: stock-manager/app/models/user.rb

```Ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :portfolio, dependent: :destroy
  accepts_nested_attributes_for :portfolio

  after_create :create_portfolio

  def create_portfolio
    Portfolio.create(user:self)
  end
end
```

## Portfolio

For this table, it was fairly basic, it simply stores the customers total investment, as well as the relationships with `Users` and `Investments`. I decided to have a something in the middle between the users account and the investments would be a better way of accessing data.

-   total_investments -> Float
-   user_id -> Integer - One to one relationship with `User`
-   shares_id -> I

#### Model

Location: stock-manager/app/models/portfolio.rb

```ruby
class Portfolio < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :investments, :foreign_key => "portfolio_id"
end
```

* * *

## Investments

This table holds investment data, such as the number of shares the initial share price, as well as the company that it pertains to.

-   shares - Integer
-   initial_cost - Float
-   stock_id -> Relational

#### Model

```ruby
class Investment < ApplicationRecord
  belongs_to :portfolio, :foreign_key => "portfolio_id"
  belongs_to :stock
end
```

* * *

## Stocks

The table stores specifics regarding each company

-   name -> String
-   symbol -> String
-   exchange -> string

#### Model

Has no associations

```ruby
class Stock < ApplicationRecord
end
```

* * *

## Foreign Keys

```ruby
  add_foreign_key "investments", "portfolios"
  add_foreign_key "investments", "stocks"
  add_foreign_key "portfolios", "users"
```

* * *

## Initial seeds

I created a quick function to generate the initial stock seeds, I chose the top 20 tech stocks to add here and pulled the details from the `worldtradingdata.com` API.

I decided to `HTTParty` for my HTTP requests, vs' the one included with rails, simply because the syntax is easier to use, and will make it easier to work with later on in the project.

```ruby
# Create initial users
user_one = User.create(email: 'manager@test.com', password: 'password', manager: true)
user_two = User.create(email: 'customer@test.com', password: 'password', manager: false)

# Create Initial Stocks
def parse_stocks(response)
  JSON.parse(response.body)['data'].each do |res|
    Stock.create('name': res['name'], 'symbol': res['symbol'], 'exchange': res['stock_exchange_short'])
  end
end

stock_symbols = ['AAPL', 'MSFT', 'TWTR', 'NFLX', 'HEAR',
                 'P', 'AMD', 'AAXN', 'AMZN', 'PANW',
                 'ADBE', 'TRIP', 'NTAP', 'EA', 'TTD',
                 'DDD', 'I', 'IQ', 'HUYA', 'MOMO', 'TWLO', 'CRM']

stock_symbols.each_slice(5).to_a.each do |symbols|
  ep = 'https://www.worldtradingdata.com/api/v1/stock?symbol=%s&api_token='
  res = HTTParty.get(ep % symbols.join(',') << ENV['STOCK_API_TOKEN'])
  parse_stocks(res)
end
```
