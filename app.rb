require 'pry'
require 'dotenv'

Dotenv.load

Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/clients/*.rb'].each { |file| require file }

GDAX = Exchange.new(name: 'GDAX', maker_fee: 0, taker_fee: 0.0025)

BITCOIN = Currency.new(name: 'Bitcoin', ticker: 'BTC')
ETHEREUM = Currency.new(name: 'Ethereum', ticker: 'ETH')

trade = Trade.new(
  date: '10:57:17 pm - Aug 10, 2017 UTC',
  order_type: 'Limit',
  transaction_type: 'Buy',
  currency: ETHEREUM,
  price: 302.52,
  quantity: 1.77972917,
  exchange: GDAX,
)

position = Position.new(
  purchase: trade,
)

require 'pry'; binding.pry
