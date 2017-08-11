class Trade
  ORDER_TYPES = ['Market', 'Limit', 'Stop']
  TRANSACTION_TYPES = ['Buy', 'Sell']

  attr_accessor :date, :order_type, :transaction_type, :price, :quantity, :currency, :exchange

  def initialize(date:nil,order_type:,transaction_type:,price:,quantity:,currency:,exchange:)
    @date = date
    @order_type = order_type
    @transaction_type = transaction_type
    @price = price
    @quantity = quantity
    @currency = currency
    @exchange = exchange

    validate_order_type!
    validate_transaction_type!
  end

  def fee
    if order_type == 'Market' || order_type == 'Stop'
      exchange.taker_fee
    else
      exchange.maker_fee
    end
  end

  def gross_total_cost
    price * quantity
  end

  def total_cost
    gross_total_cost + fee
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
