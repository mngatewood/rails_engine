require 'rails_helper'

describe "Customers favorite merchant API" do
  it "returns a merchant where the customer has conducted the most successful transactions" do
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    item_3 = create(:item, merchant_id: merchant_3.id)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_3 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_1.id)
    invoice_4 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_1.id)
    invoice_5 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer_1.id)
    invoice_6 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer_2.id)
    invoice_7 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer_2.id)
    invoice_item_1 = create(:invoice_item, quantity: 100, unit_price: 1.15, invoice_id: invoice_1.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 100, unit_price: 1, invoice_id: invoice_2.id, item_id: item_1.id)
    invoice_item_3 = create(:invoice_item, quantity: 1, unit_price: 1.33, invoice_id: invoice_3.id, item_id: item_1.id)
    invoice_item_4 = create(:invoice_item, quantity: 2, unit_price: 100, invoice_id: invoice_4.id, item_id: item_1.id)
    invoice_item_5 = create(:invoice_item, quantity: 1, unit_price: 1.49, invoice_id: invoice_5.id, item_id: item_1.id)
    invoice_item_6 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_6.id, item_id: item_2.id)
    invoice_item_7 = create(:invoice_item, quantity: 100, unit_price: 100, invoice_id: invoice_7.id, item_id: item_1.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: 'failed')
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id)
    transaction_4 = create(:transaction, invoice_id: invoice_4.id)
    transaction_5 = create(:transaction, invoice_id: invoice_5.id)
    transaction_6 = create(:transaction, invoice_id: invoice_6.id)
    transaction_7 = create(:transaction, invoice_id: invoice_7.id)

    get "/api/v1/customers/#{customer_1.id}/favorite_merchant"

    merchant = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(merchant["attributes"]["id"].to_i).to eq(merchant_2.id)

  end
end