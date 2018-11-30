require 'rails_helper'

describe "Items best day API" do
  it "returns the date with the most sales for the given item using the invoice date" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: "2018-01-01")
    invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: "2018-01-02")
    invoice_3 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: "2018-01-03")
    invoice_4 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: "2018-01-04")
    invoice_5 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: "2018-01-05")
    invoice_6 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: "2018-01-06")
    invoice_item_1 = create(:invoice_item, quantity: 4, unit_price: 2, invoice_id: invoice_1.id, item_id: item.id)
    invoice_item_2 = create(:invoice_item, quantity: 2, unit_price: 1, invoice_id: invoice_2.id, item_id: item.id)
    invoice_item_3 = create(:invoice_item, quantity: 100, unit_price: 2, invoice_id: invoice_3.id, item_id: item.id)
    invoice_item_4 = create(:invoice_item, quantity: 3, unit_price: 1000, invoice_id: invoice_4.id, item_id: item.id)
    invoice_item_5 = create(:invoice_item, quantity: 100, unit_price: 1, invoice_id: invoice_5.id, item_id: item.id)
    invoice_item_6 = create(:invoice_item, quantity: 1000, unit_price: 1000, invoice_id: invoice_6.id, item_id: item.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id)
    transaction_4 = create(:transaction, invoice_id: invoice_4.id)
    transaction_5 = create(:transaction, invoice_id: invoice_5.id)
    transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: 'failed')

    get "/api/v1/items/#{item.id}/best_day"

    best_day = JSON.parse(response.body)
    expect(response).to be_successful
    expect(best_day["date"]).to eq(invoice_5.created_at.strftime("%F"))
  end
end