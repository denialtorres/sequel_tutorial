require_relative "../bootstrap"

Sequel::Model.plugin :validation_helpers

class Product < Sequel::Model
  # belongs_to :order in AR
  # in Sequel
  one_to_many :order_items
  many_to_many :orders, join_table: :order_items

  def validate
    validates_presence [:name, :category, :price], message: "pass a value, please"
    validates_includes [ "Vegetable", "Tool", "Dairy", "Meat"], :category
    validates_max_length 10, :category
    # validates_min_length 10, :category
    # validates_exact_length 10, :category
    validates_numeric :price
    super
  end
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

product = Product.new category: "Dairy", name: 'Yogurt', price: 10.0
ap product.valid?
product.save
