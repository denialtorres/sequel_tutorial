require "bundler"
require 'logger'

Bundler.require

require "yaml"

file_path = File.expand_path "../database.yaml", __FILE__
file = YAML.load_file file_path

DB = Sequel.connect(file)

DB.loggers << Logger.new($stdout)

# Load validations for models
Sequel::Model.plugin :validation_helpers

DB.drop_table?(:order_items)
DB.drop_table?(:orders)
DB.drop_table?(:products)

DB.create_table?(:products) do
  primary_key :id
  String :name
  String :category
  Float :price
end

[
  %w(Apple Fruit),
  %w(Veal Meat),
  %w(Broccoli Vegetable),
  %w(Tomato Fruit),
  %w(Hammer Tool),
  %w(Screwdriver Tool),
  %w(Onion Vegetable)
].each do |item|
  title = item[0]
  category = item[1]
  DB[:products].insert name: title, category: category, price: rand(11.2...76.9)
end

DB.create_table?(:orders) do
  primary_key :id
end

DB.create_table?(:order_items) do
  primary_key :id
  foreign_key :product_id, :products, null: false
  foreign_key :order_id, :orders, null: false
  Integer :quantity
end
