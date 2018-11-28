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

  describe 'multi-finders' do

    it "finds all merchants by id" do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/find_all?id=#{merchants.first.id}"

      filtered_merchants = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_merchants.first["id"]).to eq(merchants.first.id)
    end
    
    it "finds all merchants by name" do
      merchant_1 = create(:merchant, name: "David Jones")
      merchant_2 = create(:merchant, name: "John Davis")
      merchant_3 = create(:merchant, name: "David Jones")
      merchant_3 = create(:merchant, name: "Sue Anderson")
      merchant_3 = create(:merchant, name: "Mike Johnson")

      get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

      filtered_merchants = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_merchants.count).to eq(2)
      expect(filtered_merchants.first["name"]).to eq(merchant_1.name)
      expect(filtered_merchants.last["name"]).to eq(merchant_1.name)
    end
    
    xit "finds a all merchants by created_at" do
      merchant_1 = create(:merchant, created_at: "2018-01-01")
      merchant_2 = create(:merchant, created_at: "2018-01-02")
      merchant_3 = create(:merchant, created_at: "2018-01-01")
      merchant_4 = create(:merchant, created_at: "2018-01-03")
      merchant_5 = create(:merchant, created_at: "2018-01-04")

      get "/api/v1/merchants/find_all?created_at=#{merchant_1.created_at}"

      filtered_merchants = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_merchants.count).to eq(2)
      expect(filtered_merchants.first["created_at"]).to eq(merchant_1.created_at)
      expect(filtered_merchants.last["created_at"]).to eq(merchant_1.created_at)
    end
    
    xit "finds a all merchants by updated_at" do
      merchant_1 = create(:merchant, updated_at: "2018-01-01")
      merchant_2 = create(:merchant, updated_at: "2018-01-02")
      merchant_3 = create(:merchant, updated_at: "2018-01-01")
      merchant_4 = create(:merchant, updated_at: "2018-01-03")
      merchant_5 = create(:merchant, updated_at: "2018-01-04")

      get "/api/v1/merchants/find_all?updated_at=#{merchant_1.updated_at}"

      filtered_merchants = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_merchants.count).to eq(2)
      expect(filtered_merchants.first["updated_at"]).to eq(merchant_1.updated_at)
      expect(filtered_merchants.last["updated_at"]).to eq(merchant_1.updated_at)
    end
    
  end

end