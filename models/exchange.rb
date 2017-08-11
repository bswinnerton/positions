class Exchange
  attr_accessor :name
  attr_reader :maker_fee, :taker_fee

  def initialize(name:,maker_fee:,taker_fee:)
    @name = name
    @maker_fee = maker_fee
    @taker_fee = taker_fee
  end

  def client
    @client ||= Object.const_get("Clients::#{name.capitalize}").new
  end
end
