require 'rails_helper'

describe "Merchants with most items sold API" do
  it "should return top x merchants by items sold" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)
    merchant_6 = create(:merchant)
    merchant_7 = create(:merchant)
    customer = create(:customer)
    merchant_1_item = create(:item, merchant_id: merchant_1.id)
    merchant_2_item = create(:item, merchant_id: merchant_2.id)
    merchant_3_item = create(:item, merchant_id: merchant_3.id)
    merchant_4_item = create(:item, merchant_id: merchant_4.id)
    merchant_5_item = create(:item, merchant_id: merchant_5.id)
    merchant_6_item = create(:item, merchant_id: merchant_6.id)
    merchant_7_item = create(:item, merchant_id: merchant_7.id)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
    invoice_3 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id)
    invoice_4 = create(:invoice, merchant_id: merchant_4.id, customer_id: customer.id)
    invoice_5 = create(:invoice, merchant_id: merchant_5.id, customer_id: customer.id)
    invoice_6 = create(:invoice, merchant_id: merchant_6.id, customer_id: customer.id)
    invoice_7 = create(:invoice, merchant_id: merchant_7.id, customer_id: customer.id)
    invoice_item_1 = create(:invoice_item, quantity: 5, unit_price: 2, invoice_id: invoice_1.id, item_id: merchant_1_item.id)
    invoice_item_2 = create(:invoice_item, quantity: 200, unit_price: 1, invoice_id: invoice_2.id, item_id: merchant_1_item.id)
    invoice_item_3 = create(:invoice_item, quantity: 1, unit_price: 1, invoice_id: invoice_3.id, item_id: merchant_2_item.id)
    invoice_item_4 = create(:invoice_item, quantity: 2, unit_price: 100, invoice_id: invoice_4.id, item_id: merchant_2_item.id)
    invoice_item_5 = create(:invoice_item, quantity: 3, unit_price: 1, invoice_id: invoice_5.id, item_id: merchant_3_item.id)
    invoice_item_6 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_6.id, item_id: merchant_3_item.id)
    invoice_item_7 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_7.id, item_id: merchant_3_item.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id)
    transaction_4 = create(:transaction, invoice_id: invoice_4.id)
    transaction_5 = create(:transaction, invoice_id: invoice_5.id)
    transaction_6 = create(:transaction, invoice_id: invoice_6.id)
    transaction_7 = create(:transaction, invoice_id: invoice_7.id, result: 'failed')

    get "/api/v1/merchants/most_items?quantity=5"

    top_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(top_merchants).to eq([
      { "id"=>merchant_2.id, "name"=>merchant_2.name, "items_sold"=>200 }, 
      { "id"=>merchant_6.id, "name"=>merchant_6.name, "items_sold"=>100 }, 
      { "id"=>merchant_1.id, "name"=>merchant_1.name, "items_sold"=>5 }, 
      { "id"=>merchant_5.id, "name"=>merchant_5.name, "items_sold"=>3 }, 
      { "id"=>merchant_4.id, "name"=>merchant_4.name, "items_sold"=>2 }
    ])
  end
end