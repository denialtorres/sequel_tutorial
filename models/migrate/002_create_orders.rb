Sequel.migration do
  change do
    create_table :orders do
      primary_key :id
    end
  end
end
