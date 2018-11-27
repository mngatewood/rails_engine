require 'csv'
require './app/models/merchant.rb'

all_merchants = CSV.read('db/csv/merchants.csv', headers: true, header_converters: :symbol)
all_merchants.each do |merchant|
  Merchant.create!(merchant.to_h)
end
