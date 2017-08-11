require 'pry'
require 'dotenv'

Dotenv.load

Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/clients/*.rb'].each { |file| require file }

EXCHANGES = {
  gdax: Exchange.new(name: 'GDAX', maker_fee: 0, taker_fee: 0.0025),
}

CURRENCIES = {
  bitcoin: Currency.new(name: 'Bitcoin', ticker: 'BTC'),
  ethereum: Currency.new(name: 'Ethereum', ticker: 'ETH'),
}

require 'pry'; binding.pry
