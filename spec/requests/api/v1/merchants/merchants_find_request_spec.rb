require "rails_helper"

describe "Merchants finders" do
  describe "single finders" do

    it "finds a single merchant by id" do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/find?id=#{merchants.first.id}"

      merchant = JSON.parse(response.body)
      expect(response).to be_successful
      expect(merchant["id"]).to eq(merchants.first.id)
    end
    
    it "finds a single merchant by name" do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/find?name=#{merchants.first.name}"

      merchant = JSON.parse(response.body)
      expect(response).to be_successful
      expect(merchant["name"]).to eq(merchants.first.name)
    end

    xit "finds a single merchant by created_at" do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/find?created_at=#{merchants.first.created_at}"

      merchant = JSON.parse(response.body)
      expect(response).to be_successful
      expect(merchant["created_at"]).to eq(merchants.first.created_at)
    end

    xit "finds a single merchant by updated_at" do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/find?updated_at=#{merchants.first.updated_at}"

      merchant = JSON.parse(response.body)
      expect(response).to be_successful
      expect(merchant["updated_at"]).to eq(merchants.first.updated_at)
    end

  end

  describe "multi finders" do

  end

end