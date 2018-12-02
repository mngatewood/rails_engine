require 'rails_helper'

describe "Transactions API" do

  it "returns a list of all transactions" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create_list(:transaction, 3, invoice: invoice)

    get "/api/v1/transactions"

    transactions = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(transactions.count).to eq(3)
  end

  it "returns a single transaction for a given id" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    id = create(:transaction, invoice: invoice).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(transaction["attributes"]["id"].to_i).to eq(id)
  end

end