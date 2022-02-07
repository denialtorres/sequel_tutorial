Sequel.migration do
  change do
    create_table :order_items do
      primary_key :id
      foreign_key :product_id, :products, null: false
      foreign_key :order_id, :orders, null: false
      Integer :quantity
    end
  end
end
