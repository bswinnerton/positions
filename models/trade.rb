class Trade
  ORDER_TYPES = [:market, :limit]
  TRANSACTION_TYPES = [:buy, :sell]

  attr_accessor :date, :order_type, :transaction_type, :price, :currency, :exchange

  def self.all
    EXCHANGES.values.flat_map(&:trades).reverse
  end

  def initialize(date:nil,order_type:,transaction_type:,price:,quantity:,currency:,exchange:,fee:)
    @date = date
    @order_type = order_type
    @transaction_type = transaction_type
    @price = price
    @quantity = quantity
    @currency = currency
    @exchange = exchange
    @fee = fee

    validate_order_type!
    validate_transaction_type!
  end

  def market_order?
    order_type == :market
  end

  def limit_order?
    order_type == :limit
  end

  def purchase?
    transaction_type == :buy
  end

  def sale?
    transaction_type == :sell
  end

  def fee
    return @fee if @fee

    if market_order?
      exchange.taker_fee
    else
      exchange.maker_fee
    end
  end

  def quantity
    @quantity
  end

  def gross_total_cost
    (price * quantity).abs
  end

  def total_cost
    (gross_total_cost + fee).abs
  end

  def exchange_currency
    ExchangeCurrency.new(currency: currency, exchange: exchange)
  end

  private

  def validate_order_type!
    unless ORDER_TYPES.include?(order_type)
      raise ArgumentError, "#{@order_type} is not a valid order type."
    end
  end

  def validate_transaction_type!
    unless TRANSACTION_TYPES.include?(transaction_type)
      raise ArgumentError, "#{@order_type} is not a valid transaction type."
    end
  end
end
