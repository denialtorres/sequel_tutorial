require_relative "../bootstrap"

ap DB[:products].all

id =  DB[:products].insert name: 'Yogurt', category: "Dairy", price: 0.10

ap DB[:products].where(id: id).update(price: 0.2, name: 'Iogurte')
