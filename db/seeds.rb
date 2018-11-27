require 'csv'
require './app/models/merchant.rb'
require './app/models/item.rb'

merchants = CSV.read('db/csv/merchants.csv', headers: true, header_converters: :symbol)
merchants.each do |merchant|
  Merchant.create!(merchant.to_h)
end

items = CSV.read('db/csv/items.csv', headers: true, header_converters: :symbol)
items.each do |item|
  Item.create!(item.to_h)
end
