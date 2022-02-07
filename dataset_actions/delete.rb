require_relative "../bootstrap"

# binding.pry

DB[:products].where(id: 3).delete
DB[:products].where(id: 4..6).delete
