require "rails_helper"

describe "Merchants finders" do
  describe "random finder" do

    it "returns a random merchant" do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/random"

      merchant = JSON.parse(response.body)
      expect(response).to be_successful
      expect(merchant["id"]).to be_between(merchants.first.id, merchants.last.id)
    end

  end
end