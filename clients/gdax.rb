require 'coinbase/exchange'

module Clients
  class Gdax
    def trading_price(ticker)
      client.last_trade(product_id: "#{ticker.upcase}-USD").fetch('price').to_i
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
