require 'rails_helper'

describe "Merchants revenue API" do
  it "should return the total revenue for date across all merchants" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    customer = create(:customer)
    merchant_1_item = create(:item, merchant_id: merchant_1.id)
    merchant_2_item = create(:item, merchant_id: merchant_2.id)
    merchant_3_item = create(:item, merchant_id: merchant_3.id)
    invoice_1 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_2 = create(:invoice, created_at: "2018-01-02", merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_3 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_2.id, customer_id: customer.id)
    invoice_4 = create(:invoice, created_at: "2018-01-02", merchant_id: merchant_2.id, customer_id: customer.id)
    invoice_5 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_3.id, customer_id: customer.id)
    invoice_6 = create(:invoice, created_at: "2018-01-02", merchant_id: merchant_3.id, customer_id: customer.id)
    invoice_7 = create(:invoice, created_at: "2018-01-01", merchant_id: merchant_3.id, customer_id: customer.id, status: "pending")
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 1, invoice_id: invoice_1.id, item_id: merchant_1_item.id)
    invoice_item_2 = create(:invoice_item, quantity: 100, unit_price: 1, invoice_id: invoice_2.id, item_id: merchant_1_item.id)
    invoice_item_3 = create(:invoice_item, quantity: 1, unit_price: 1, invoice_id: invoice_3.id, item_id: merchant_2_item.id)
    invoice_item_4 = create(:invoice_item, quantity: 1, unit_price: 100, invoice_id: invoice_4.id, item_id: merchant_2_item.id)
    invoice_item_5 = create(:invoice_item, quantity: 1, unit_price: 1, invoice_id: invoice_5.id, item_id: merchant_3_item.id)
    invoice_item_6 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_6.id, item_id: merchant_3_item.id)
    invoice_item_7 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_7.id, item_id: merchant_3_item.id)

    get "/api/v1/merchants/revenue?date=#{invoice_1.created_at}"

    revenue = JSON.parse(response.body)
    expect(response).to be_successful
    expect(revenue).to eq(3)

  end
end