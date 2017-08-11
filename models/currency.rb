class Currency
  attr_accessor :name, :ticker

  def initialize(name:,ticker:)
    @name = name
    @ticker = ticker.upcase
  end
end
