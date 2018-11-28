require "rails_helper"

describe "Invoices API" do
  it "sends a list of invoices" do
    merchant = create(:merchant)
    customer = create(:customer)
    create_list(:invoice, 3, 
                merchant_id: merchant.id, 
                customer_id: customer.id)

    get "/api/v1/invoices"

    invoices = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoices.count).to eq(3)
  end

  it "can get an invoice by its id" do
    merchant = create(:merchant)
    customer = create(:customer)
    id = create(:invoice,
                merchant_id: merchant.id,
                customer_id: customer.id).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["id"]).to eq(id)
  end
end