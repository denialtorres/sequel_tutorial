require_relative "../bootstrap"

list =  DB[:products].all

class Product < Sequel::Model
end
#
ap Product.where(id: 1).first
ap Product.limit(3).all
ap Product.limit(3).order(:category).all


# crete new product
yogurt = Product.new name: "Yogurt", category: "Dairy", price: 0.10
ap yogurt.save

yogurt.update name: 'Milk', price: 888

ap yogurt.destroy
