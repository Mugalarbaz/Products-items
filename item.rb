class Item
  attr_reader :name, :unit_price, :sale_price_quantity, :sale_price

  def initialize(name, unit_price, sale_price_quantity = nil, sale_price = nil)
    @name = name
    @unit_price = unit_price
    @sale_price_quantity = sale_price_quantity
    @sale_price = sale_price
  end
end
