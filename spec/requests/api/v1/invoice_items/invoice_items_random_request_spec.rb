require "rails_helper"

describe "Invoice items finders" do
  describe "random finder" do

    it "returns a random invoice item" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_items = create_list(:invoice_item, 3, invoice: invoice, item: item)

      get "/api/v1/invoice_items/random"

      invoice_item = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice_item["attributes"]["id"].to_i).to be_between(invoice_items.first.id, invoice_items.last.id)
    end

  end
end