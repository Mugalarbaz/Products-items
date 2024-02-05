require_relative 'item'
require_relative 'receipt'
require_relative 'main'

PRICING_TABLE = {
  'Milk'   => Item.new('Milk', 3.97, 2, 5.00),
  'Bread'  => Item.new('Bread', 2.17, 3, 6.00),
  'Banana' => Item.new('Banana', 0.99),
  'Apple'  => Item.new('Apple', 0.89)
}

receipt = Receipt.new(PRICING_TABLE)
checkout_interface = Main.new(receipt)
checkout_interface.start_checkout_process
