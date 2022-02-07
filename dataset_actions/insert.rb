require_relative "../bootstrap"

# ap DB[:products].all

ap DB[:products].insert name: 'Yogurt', category: "Dairy", price: 0.10

ap DB[:products].order(:id).last
