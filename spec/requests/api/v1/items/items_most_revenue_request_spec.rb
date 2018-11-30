require 'rails_helper'

describe "Items most revenue API" do
  it "should return a list of items with most revenue" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_1.id)
    item_3 = create(:item, merchant_id: merchant_2.id)
    item_4 = create(:item, merchant_id: merchant_2.id)
    item_5 = create(:item, merchant_id: merchant_3.id)
    item_6 = create(:item, merchant_id: merchant_3.id)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
    invoice_3 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id)
    invoice_item_1 = create(:invoice_item, quantity: 100, unit_price: 1, invoice_id: invoice_1.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 2, unit_price: 100, invoice_id: invoice_1.id, item_id: item_2.id)
    invoice_item_3 = create(:invoice_item, quantity: 4, unit_price: 100, invoice_id: invoice_2.id, item_id: item_3.id)
    invoice_item_4 = create(:invoice_item, quantity: 3, unit_price: 100, invoice_id: invoice_2.id, item_id: item_4.id)
    invoice_item_5 = create(:invoice_item, quantity: 1000, unit_price: 1000, invoice_id: invoice_3.id, item_id: item_5.id)
    invoice_item_6 = create(:invoice_item, quantity: 1000, unit_price: 100, invoice_id: invoice_3.id, item_id: item_6.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: 'failed')

    get "/api/v1/items/most_revenue?quantity=3"

    items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(items.map{|i|i["id"]}).to eq([item_3.id, item_4.id, item_2.id])
  end
end