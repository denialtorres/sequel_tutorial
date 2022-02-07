Sequel.migration do
  change do
    create_table :products do
      primary_key :id
      String :name
      String :category
      Float :price
    end
  end
end
