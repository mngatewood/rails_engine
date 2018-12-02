require "rails_helper"

describe "Invoice Items API" do
  it "sends a list of invoice_items" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, 
                      merchant_id: merchant.id, 
                      customer_id: customer.id)
    create_list(:invoice_item, 3, 
                invoice_id: invoice.id, 
                item_id: item.id)

    get "/api/v1/invoice_items"

    invoice_items = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(invoice_items.count).to eq(3)
  end

  it "can get an invoice_item by its id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, 
                      merchant: merchant, 
                      customer: customer)
    id = create(:invoice_item,
                invoice_id: invoice.id,
                item_id: item.id).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(invoice_item["attributes"]["id"]).to eq(id)
  end
end