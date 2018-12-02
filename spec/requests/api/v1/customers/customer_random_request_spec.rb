require "rails_helper"

describe "Customers finders" do
  describe "random finder" do

    it "returns a random customer" do
      customers = create_list(:customer, 3)

      get "/api/v1/customers/random"

      customer = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(customer["attributes"]["id"]).to be_between(customers.first.id, customers.last.id)
    end

  end
end