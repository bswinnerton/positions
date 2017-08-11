class Position
  attr_accessor :purchase, :exit

  def initialize(purchase:,sale:nil)
    @purchase = purchase
    @sale = sale
  end

  def realized?
    purchase && sale
  end

  def profitable?
    profit > 0
  end

  def unprofitable?
    !profitable?
  end

  def profit
    potential_sale.total_cost - purchase.total_cost
  end

  def potential_sale
    Trade.new(
      order_type: 'Limit',
      transaction_type: 'Sell',
      currency: purchase.currency,
      price: purchase.exchange_currency.trading_price,
      quantity: purchase.quantity,
      exchange: purchase.exchange,
    )
  end
end
