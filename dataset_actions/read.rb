require_relative "../bootstrap"

ap DB[:products].all


ap DB[:products].where(id: 1).all

ap DB[:products].order(:id).last

ap DB[:products].where(id: 1..5).order(:name)
ap DB[:products].where(id: 1..5).order(:name).all


ap DB[:products].where(id: [1,3,5]).order(:name)
ap DB[:products].where(id: [1,3,5]).order(:name).all

# passing regular expressions

ap DB[:products].where(Sequel.like(:name, "%ppl%")).order(:name)
ap DB[:products].where(Sequel.like(:name, "%ppl%")).order(:name).all

# using a proc
ap DB[:products].where{ price < 30 }.order(:name)
ap DB[:products].where{ price < 30 }.order(:name).all

# order by desc order
ap DB[:products].where{ price < 30 }.reverse_order(:name)
ap DB[:products].where{ price < 30 }.reverse_order(:name).all

# limit method and offset
ap DB[:products].limit 3
ap DB[:products].limit(3).all

# limit method and offset
ap DB[:products].limit(3).offset(2)
ap DB[:products].limit(3).offset(2).all
