require "rails_helper"

describe "Transactions finders" do
  describe "random finder" do

    it "returns a random transaction" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transactions = create_list(:transaction, 3, invoice: invoice)

      get "/api/v1/transactions/random"

      transaction = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(transaction["attributes"]["id"]).to be_between(transactions.first.id, transactions.last.id)
    end

  end
end