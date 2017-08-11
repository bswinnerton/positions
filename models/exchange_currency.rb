class ExchangeCurrency
  attr_reader :exchange
  attr_reader :currency

  def initialize(exchange:,currency:)
    @exchange = exchange
    @currency = currency
  end

  def trading_price
    exchange.client.trading_price(currency.ticker)
  end
end
