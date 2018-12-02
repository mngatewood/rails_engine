require "rails_helper"

describe "Items finders" do
  describe "random finder" do

    it "returns a random item" do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/items/random"

      item = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(item["attributes"]["id"]).to be_between(items.first.id, items.last.id)
    end

  end
end