require "rails_helper"

describe "Merchants finders" do
  describe "single finders" do

    it "finds a single merchant by id" do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/find?id=#{merchants.first.id}"

      merchant = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(merchant["attributes"]["id"].to_i).to eq(merchants.first.id)
    end
    
    it "finds a single merchant by name" do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/find?name=#{merchants.first.name}"

      merchant = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(merchant["attributes"]["name"]).to eq(merchants.first.name)
    end

    it "finds a single merchant by created_at" do
      merchant_1 = create(:merchant, created_at: "2018-01-01T11:11:11.000Z")
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/find?created_at=#{merchant_1.created_at}"

      merchant = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(merchant["attributes"]["id"].to_i).to eq(merchant_1.id)
    end

    it "finds a single merchant by updated_at" do
      merchant_1 = create(:merchant, updated_at: "2018-01-01T11:11:11.000Z")
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/find?updated_at=#{merchant_1.updated_at}"

      merchant = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(merchant["attributes"]["id"].to_i).to eq(merchant_1.id)
    end

  end

  describe 'multi-finders' do

    it "finds all merchants by id" do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/find_all?id=#{merchants.first.id}"

      filtered_merchants = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_merchants.first["attributes"]["id"].to_i).to eq(merchants.first.id)
    end
    
    it "finds all merchants by name" do
      merchant_1 = create(:merchant, name: "David Jones")
      merchant_2 = create(:merchant, name: "John Davis")
      merchant_3 = create(:merchant, name: "David Jones")
      merchant_3 = create(:merchant, name: "Sue Anderson")
      merchant_3 = create(:merchant, name: "Mike Johnson")

      get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

      filtered_merchants = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_merchants.count).to eq(2)
      expect(filtered_merchants.first["attributes"]["name"]).to eq(merchant_1.name)
      expect(filtered_merchants.last["attributes"]["name"]).to eq(merchant_1.name)
    end
    
    it "finds a all merchants by created_at" do
      merchant_1 = create(:merchant, created_at: "2018-01-01T11:11:11.000Z")
      merchant_2 = create(:merchant, created_at: "2018-01-02T11:11:11.000Z")
      merchant_3 = create(:merchant, created_at: "2018-01-02T11:11:11.000Z")
      merchant_4 = create(:merchant, created_at: "2018-01-02T11:11:11.000Z")

      get "/api/v1/merchants/find_all?created_at=#{merchant_2.created_at}"

      filtered_merchants = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_merchants.count).to eq(3)
      expect(filtered_merchants.first["attributes"]["id"].to_i).to eq(merchant_2.id)
    end
    
    it "finds a all merchants by updated_at" do
      merchant_1 = create(:merchant, updated_at: "2018-01-01T11:11:11.000Z")
      merchant_2 = create(:merchant, updated_at: "2018-01-02T11:11:11.000Z")
      merchant_3 = create(:merchant, updated_at: "2018-01-02T11:11:11.000Z")
      merchant_4 = create(:merchant, updated_at: "2018-01-02T11:11:11.000Z")

      get "/api/v1/merchants/find_all?updated_at=#{merchant_2.updated_at}"

      filtered_merchants = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_merchants.count).to eq(3)
      expect(filtered_merchants.first["attributes"]["id"].to_i).to eq(merchant_2.id)
    end
    
  end
end