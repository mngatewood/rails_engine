require 'rails_helper'
require 'uri'

describe "Merchants revenue API" do

  it "should return the total revenue for date across all merchants" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    item_3 = create(:item, merchant_id: merchant_3.id)
    invoice_1 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_2 = create(:invoice, created_at: "2018-01-02", merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_3 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_2.id, customer_id: customer.id)
    invoice_4 = create(:invoice, created_at: "2018-01-02", merchant_id: merchant_2.id, customer_id: customer.id)
    invoice_5 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_3.id, customer_id: customer.id)
    invoice_6 = create(:invoice, created_at: "2018-01-02", merchant_id: merchant_3.id, customer_id: customer.id)
    invoice_7 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_3.id, customer_id: customer.id)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 1, invoice_id: invoice_1.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 100, unit_price: 1, invoice_id: invoice_2.id, item_id: item_1.id)
    invoice_item_3 = create(:invoice_item, quantity: 1, unit_price: 1, invoice_id: invoice_3.id, item_id: item_2.id)
    invoice_item_4 = create(:invoice_item, quantity: 1, unit_price: 100, invoice_id: invoice_4.id, item_id: item_2.id)
    invoice_item_5 = create(:invoice_item, quantity: 1, unit_price: 1, invoice_id: invoice_5.id, item_id: item_3.id)
    invoice_item_6 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_6.id, item_id: item_3.id)
    invoice_item_7 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_7.id, item_id: item_3.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id)
    transaction_4 = create(:transaction, invoice_id: invoice_4.id)
    transaction_5 = create(:transaction, invoice_id: invoice_5.id)
    transaction_6 = create(:transaction, invoice_id: invoice_6.id)
    transaction_7 = create(:transaction, invoice_id: invoice_7.id, result: 'failed')

    date = URI.encode(invoice_1.created_at.to_formatted_s(:db))
    get "/api/v1/merchants/revenue?date=#{date}"

    revenue = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(revenue["attributes"]["total_revenue"].to_f).to eq(3.0)
  end
  
  it "should return the total revenue for that merchant across successful transactions" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_3 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_4 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 1.43, invoice_id: invoice_1.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 5, unit_price: 1.12, invoice_id: invoice_2.id, item_id: item_1.id)
    invoice_item_3 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_3.id, item_id: item_2.id)
    invoice_item_4 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_4.id, item_id: item_2.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: 'failed')
    transaction_4 = create(:transaction, invoice_id: invoice_4.id)

    get "/api/v1/merchants/#{merchant_1.id}/revenue"

    revenue = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(revenue.first["attributes"]["total_revenue"]).to eq(7.03)
  end

  it "should return the total revenue for that merchant for a specific invoice date" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    invoice_1 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_2 = create(:invoice, created_at: "2018-01-02", merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_3 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_4 = create(:invoice, created_at: "2018-01-02", merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_5 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_6 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_2.id, customer_id: customer.id)
    invoice_7 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 1.15, invoice_id: invoice_1.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 100, unit_price: 1, invoice_id: invoice_2.id, item_id: item_1.id)
    invoice_item_3 = create(:invoice_item, quantity: 1, unit_price: 1.33, invoice_id: invoice_3.id, item_id: item_1.id)
    invoice_item_4 = create(:invoice_item, quantity: 2, unit_price: 100, invoice_id: invoice_4.id, item_id: item_1.id)
    invoice_item_5 = create(:invoice_item, quantity: 1, unit_price: 1.49, invoice_id: invoice_5.id, item_id: item_1.id)
    invoice_item_6 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_6.id, item_id: item_2.id)
    invoice_item_7 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_7.id, item_id: item_1.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id)
    transaction_4 = create(:transaction, invoice_id: invoice_4.id)
    transaction_5 = create(:transaction, invoice_id: invoice_5.id)
    transaction_6 = create(:transaction, invoice_id: invoice_6.id)
    transaction_7 = create(:transaction, invoice_id: invoice_7.id, result: 'failed')

    date = URI.encode(invoice_1.created_at.to_formatted_s(:db))
    get "/api/v1/merchants/#{merchant_1.id}/revenue?date=#{date}"

    revenue = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(revenue.first["attributes"]["total_revenue"]).to eq(3.97)
  end

end