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

Trade.all.each do |trade|
  verb = trade.purchase? ? "Purchased" : "Sold"
  puts "#{verb} #{trade.quantity} #{trade.currency.name} @ #{trade.price} for $#{trade.total_cost}"
end
