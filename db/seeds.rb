require 'csv'
require './app/models/merchant.rb'
require './app/models/item.rb'
require './app/models/customer.rb'
require './app/models/invoice.rb'
require './app/models/invoice_item.rb'
require './app/models/transaction.rb'

merchants = CSV.read('db/csv/merchants.csv', headers: true, header_converters: :symbol)
merchants.each do |merchant|
  Merchant.create!(merchant.to_h)
end

items = CSV.read('db/csv/items.csv', headers: true, header_converters: :symbol)
items.each do |item|
  Item.create!(item.to_h)
end

customers = CSV.read('db/csv/customers.csv', headers: true, header_converters: :symbol)
customers.each do |customer|
  Customer.create!(customer.to_h)
end

invoices = CSV.read('db/csv/invoices.csv', headers: true, header_converters: :symbol)
invoices.each do |invoice|
  Invoice.create!(invoice.to_h)
end

invoice_items = CSV.read('db/csv/invoice_items.csv', headers: true, header_converters: :symbol)
invoice_items.each do |invoice_item|
  InvoiceItem.create!(invoice_item.to_h)
end

transactions = CSV.read('db/csv/transactions.csv', headers: true, header_converters: :symbol)
transactions.each do |transaction|
  tx_hash = transaction.to_h
  tx_hash[:credit_card_expiration_date] = '0000'
  Transaction.create!(tx_hash)
end

