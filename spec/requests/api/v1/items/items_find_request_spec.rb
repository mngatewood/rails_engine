require "rails_helper"

describe "Items finders" do
  describe "single finders" do

    it "finds a single item by id" do
    merchant = create(:merchant)
    items = create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/items/find?id=#{items.first.id}"

      item = JSON.parse(response.body)
      expect(response).to be_successful
      expect(item["id"]).to eq(items.first.id)
    end
    
    it "finds a single item by name" do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/items/find?name=#{items.first.name}"

      item = JSON.parse(response.body)
      expect(response).to be_successful
      expect(item["name"]).to eq(items.first.name)
    end

    it "finds a single item by description" do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/items/find?description=#{items.first.description}"

      item = JSON.parse(response.body)
      expect(response).to be_successful
      expect(item["id"]).to eq(items.first.id)
    end

    it "finds a single item by unit price" do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/items/find?unit_price=#{items.first.unit_price}"

      item = JSON.parse(response.body)
      expect(response).to be_successful
      expect(item["id"].to_f).to eq(items.first.id)
    end

    it "finds a single item by merchant id" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_2.id)
      item_3 = create(:item, merchant_id: merchant_3.id)

      get "/api/v1/items/find?merchant_id=#{item_1.merchant_id}"

      item = JSON.parse(response.body)
      expect(response).to be_successful
      expect(item["id"]).to eq(item_1.id)
    end

    xit "finds a single merchant by created_at" do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/items/find?created_at=#{items.first.created_at}"

      item = JSON.parse(response.body)
      expect(response).to be_successful
      expect(item["id"]).to eq(items.first.id)
    end

    xit "finds a single merchant by updated_at" do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/items/find?updated_at=#{items.first.updated_at}"

      item = JSON.parse(response.body)
      expect(response).to be_successful
      expect(item["id"]).to eq(items.first.id)
    end

  end

  describe "multi finders" do

  end

end