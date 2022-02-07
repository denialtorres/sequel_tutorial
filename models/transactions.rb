require_relative "../bootstrap"

class Product < Sequel::Model
  # belongs_to :order in AR
  # in Sequel
  one_to_many :order_items
  many_to_many :orders, join_table: :order_items
end

class Order < Sequel::Model
  one_to_many :order_items
  many_to_many :products, join_table: :order_items
end

class OrderItem < Sequel::Model
  many_to_one :order
  many_to_one :product

  def total_price
    (quantity * product.price)&.round 2
  end
end

class OrderCreator
  def initialize data
    @data = data.sort { |item, next_| item[0] <=> next_[0]}
  end

  def execute
    find_products
    begin
      DB.transaction do
        create_order
        add_items_to_order
      end
    rescue
    end
    print_order
  end

  private

  def find_products
    @product_ids = @data.map{ |row| row[0] }
    @products = Product.order(:id).where(id: @product_ids).all
  end

  def create_order
    @order = Order.new
    @order.save
    ap Order.all
  end

  def add_items_to_order
    quantities = @data.map{ |row| row[1] }
    order_items_data = @products.zip quantities
    order_items_data.each do |item|
      @order.add_order_item product: item[0], quantity: item[1]
    end
  end

  def print_order
    ap Order.all
    @order.order_items.each do |item|
      ap "#{item.product.name}: #{item.quantity} == #{item.total_price}"
    end
  end
end
# products will belong ot a order
# order has_many products via order items

OrderCreator.new([
  # [ id, quantity ]
  [ 2, 4 ],
  [ 3, 5 ]
]).execute
