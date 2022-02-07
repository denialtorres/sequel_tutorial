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


# products will belong ot a order
# order has_many products via order items

order = Order.new
order.save

products = Product.where(id: [2,3]).all

products.each do |product|
  # for one to many
  # add_#{model}

  order.add_order_item product: product, quantity: 3
end

order.order_items.each do |item|
  ap "#{item.product.name} (#{item.quantity}) #{item.total_price}"
end
