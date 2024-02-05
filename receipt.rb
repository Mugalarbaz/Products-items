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
    item_details = []

    @items.each do |item, quantity|
      unit_price = @pricing_table[item].unit_price
      sale_price_quantity = @pricing_table[item].sale_price_quantity
      price_paid_for_item = 0.0

      if sale_price_quantity && quantity >= sale_price_quantity
        sale_count = quantity / sale_price_quantity
        remaining_count = quantity % sale_price_quantity
        price_paid_for_item = (sale_count * @pricing_table[item].sale_price + remaining_count * unit_price)
      else
        price_paid_for_item = quantity * unit_price
      end

      total_price += price_paid_for_item
      item_details << [item, quantity, price_paid_for_item]
    end

    [total_price, item_details]
  end

  def calculate_saved_amount(total_price)
    original_price = @items.sum { |item, quantity| quantity * @pricing_table[item].unit_price }
    original_price - total_price
  end
end
