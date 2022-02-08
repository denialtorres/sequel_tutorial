require_relative "../bootstrap"

class Sequel::Model
  def before_create
    self.created_at ||= Time.now
    super
  end

  def before_save
    self.updated_at = Time.now
    super
  end
end

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

product = Product.new name: "Yogurt"
product.save

ap product

sleep 4
product.update name: "Milk"
product.save

ap product
