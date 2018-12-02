require "rails_helper"

describe "Invoices finders" do
  describe "random finder" do

    it "returns a random invoice" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoices = create_list(:invoice, 3, merchant: merchant, customer: customer)

      get "/api/v1/invoices/random"

      invoice = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice["attributes"]["id"]).to be_between(invoices.first.id, invoices.last.id)
    end

  end
end