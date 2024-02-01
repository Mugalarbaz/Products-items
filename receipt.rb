require_relative 'item'

class Receipt
  def initialize(pricing_table)
    @pricing_table = pricing_table
    @items = Hash.new(0)
  end

  def process_items(item_list)
    item_list.each do |item|
      item_name = item.strip.capitalize
      @items[item_name] += 1 if @pricing_table.key?(item_name)
    end
  end

  def calculate_total
    total_price = 0.0

    @items.each do |item, quantity|
      unit_price = @pricing_table[item].unit_price
      sale_price_quantity = @pricing_table[item].sale_price_quantity

      if sale_price_quantity && quantity >= sale_price_quantity
        sale_count = quantity / sale_price_quantity
        remaining_count = quantity % sale_price_quantity

        total_price += (sale_count * @pricing_table[item].sale_price + remaining_count * unit_price)
      else
        total_price += quantity * unit_price
      end
    end

    total_price
  end

  def print_receipt
    puts "\nItem     Quantity      Price\n--------------------------------------"
    @items.each do |item, quantity|
      unit_price = @pricing_table[item].unit_price
      puts "#{item.ljust(8)} #{quantity.to_s.ljust(12)} $#{'%.2f' % (quantity * unit_price)}"
    end
    total_price = calculate_total
    puts "\nTotal price : $#{'%.2f' % total_price}"
    puts "You saved $#{'%.2f' % calculate_saved_amount(total_price)} today."
  end

  private

  def calculate_saved_amount(total_price)
    original_price = @items.sum { |item, quantity| quantity * @pricing_table[item].unit_price }
    original_price - total_price
  end
end
