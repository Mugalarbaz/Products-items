require_relative 'receipt'

class Main
  def initialize(receipt)
    @receipt = receipt
  end

  def start_checkout_process
    puts "Please enter all the items purchased separated by a comma"
    user_input = gets.chomp.split(',')

    @receipt.process_items(user_input)
    total_price, item_details = @receipt.calculate_total
    display_receipt(item_details, total_price)
  end

  private

  def display_receipt(item_details, total_price)
    puts "\nItem     Quantity      Price\n--------------------------------------"
    item_details.each do |(item, quantity, price)|
      puts "#{item.ljust(8)} #{quantity.to_s.ljust(12)} $#{'%.2f' % price}"
    end
    puts "\nTotal price : $#{'%.2f' % total_price}"
    saved_amount = @receipt.calculate_saved_amount(total_price)
    puts "You saved $#{'%.2f' % saved_amount} today."
  end
end
