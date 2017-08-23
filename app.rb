require 'pry'
require 'dotenv'

Dotenv.load

Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/clients/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each { |file| require file }

EXCHANGES = {
  gdax: Exchange.new(name: 'GDAX', maker_fee: 0, taker_fee: 0.0025),
}

CURRENCIES = {
  btc: Currency.new(name: 'Bitcoin', ticker: 'BTC'),
  eth: Currency.new(name: 'Ethereum', ticker: 'ETH'),
  ltc: Currency.new(name: 'Litecoin', ticker: 'LTC'),
}

output = Terminal.new

Trade.all.each do |trade|
  row = output.row

  row << trade.date.strftime('%B %-d, %Y %l:%m %p')

  if trade.purchase?
    row.add_element("BUY", color: :green)
  else
    row.add_element("SELL", color: :red)
  end

  row << trade.quantity
  trade_price = '%.2f' % trade.price
  row << "#{trade.currency.ticker} @ $#{trade_price}"
  row << "="

  total_cost = '%.2f' % trade.total_cost
  row.add_element("$#{total_cost}", color: :cyan)

  row.add_newline
end

puts output.to_s
