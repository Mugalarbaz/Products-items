require_relative 'item'
require_relative 'receipt'

class DiscountCalculator
  PRICING_TABLE = {
    'Milk'   => Item.new('Milk', 3.97, 2, 5.00),
    'Bread'  => Item.new('Bread', 2.17, 3, 6.00),
    'Banana' => Item.new('Banana', 0.99),
    'Apple'  => Item.new('Apple', 0.89)
  }

  def self.run
    puts "Please enter all the items purchased separated by a comma"
    user_input = gets.chomp.split(',')

    receipt = Receipt.new(PRICING_TABLE)
    receipt.process_items(user_input)
    receipt.print_receipt
  end
end
