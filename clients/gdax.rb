require 'coinbase/exchange'

module Clients
  class Gdax
    def trading_price(ticker)
      client.last_trade(product_id: "#{ticker.upcase}-USD").fetch('price').to_i
    end

    def trades
      client.fills.map do |fill|
        order_type = fill.fetch('liquidity') == 'T' ? :limit : :market
        currency = fill.fetch('product_id').split('-').first.downcase.to_sym

        Trade.new(
          date: DateTime.parse(fill.fetch('created_at')),
          order_type: order_type,
          transaction_type: fill.fetch('side').downcase.to_sym,
          currency: currency,
          price: fill.fetch('price').to_f,
          quantity: fill.fetch('size').to_f,
          fee: fill.fetch('fee').to_f,
          exchange: EXCHANGES[:gdax],
        )
      end
    end

    private

    def client
      @client ||= Coinbase::Exchange::Client.new(
        ENV.fetch('GDAX_API_KEY'),
        ENV.fetch('GDAX_API_SECRET'),
        ENV.fetch('GDAX_API_PASSWORD')
      )
    end
  end
end
