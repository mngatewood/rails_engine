require "rails_helper"
require "URI"

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

  describe 'multi-finders' do

    it "finds all items by id" do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/items/find_all?id=#{items.first.id}"

      filtered_items = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_items.first["id"]).to eq(items.first.id)
    end
    
    it "finds all items by name" do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id, name: "Television")
      item_2 = create(:item, merchant_id: merchant.id, name: "Speakers")
      item_3 = create(:item, merchant_id: merchant.id, name: "Television")
      item_4 = create(:item, merchant_id: merchant.id, name: "Microwave")
      item_5 = create(:item, merchant_id: merchant.id, name: "Blender")

      get "/api/v1/items/find_all?name=#{item_1.name}"

      filtered_items = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_items.count).to eq(2)
      expect(filtered_items.first["name"]).to eq(item_1.name)
      expect(filtered_items.last["name"]).to eq(item_1.name)
    end
    
    it "finds all items by description" do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id, description: "It shows movies")
      item_2 = create(:item, merchant_id: merchant.id, description: "It plays sound")
      item_3 = create(:item, merchant_id: merchant.id, description: "It shows movies")
      item_4 = create(:item, merchant_id: merchant.id, description: "It heats food")
      item_5 = create(:item, merchant_id: merchant.id, description: "It mixes food")

      description = URI.encode(item_1.description)
      get "/api/v1/items/find_all?description=#{description}"

      filtered_items = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_items.count).to eq(2)
      expect(filtered_items.first["description"]).to eq(item_1.description)
      expect(filtered_items.last["description"]).to eq(item_1.description)
    end
    
    it "finds all items by unit price" do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id, unit_price: 899.00)
      item_2 = create(:item, merchant_id: merchant.id, unit_price: 199.00)
      item_3 = create(:item, merchant_id: merchant.id, unit_price: 899.00)
      item_4 = create(:item, merchant_id: merchant.id, unit_price: 49.99)
      item_5 = create(:item, merchant_id: merchant.id, unit_price: 19.99)

      unit_price = URI.encode(item_1.unit_price.to_s)
      get "/api/v1/items/find_all?unit_price=#{unit_price}"

      filtered_items = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_items.count).to eq(2)
      expect(filtered_items.first["unit_price"]).to eq(item_1.unit_price.to_s)
      expect(filtered_items.last["unit_price"]).to eq(item_1.unit_price.to_s)
    end
    
    it "finds all items by merchant_id" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_2.id)
      item_3 = create(:item, merchant_id: merchant_1.id)
      item_4 = create(:item, merchant_id: merchant_2.id)
      item_5 = create(:item, merchant_id: merchant_3.id)

      get "/api/v1/items/find_all?merchant_id=#{item_1.merchant_id}"

      filtered_items = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_items.count).to eq(2)
      expect(filtered_items.first["id"]).to eq(item_1.id)
      expect(filtered_items.last["id"]).to eq(item_3.id)
    end
    
    it "finds a all items by created_at" do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id, created_at: "2018-01-01")
      item_2 = create(:item, merchant_id: merchant.id, created_at: "2018-01-02")
      item_3 = create(:item, merchant_id: merchant.id, created_at: "2018-01-01")
      item_4 = create(:item, merchant_id: merchant.id, created_at: "2018-01-03")
      item_5 = create(:item, merchant_id: merchant.id, created_at: "2018-01-04")

      created_at = URI.encode(item_1.created_at.to_formatted_s(:db))
      get "/api/v1/items/find_all?created_at=#{created_at}"

      filtered_items = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_items.count).to eq(2)
      expect(filtered_items.first["id"]).to eq(item_1.id)
      expect(filtered_items.last["id"]).to eq(item_3.id)
    end
    
    it "finds a all items by updated_at" do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id, updated_at: "2018-01-01")
      item_2 = create(:item, merchant_id: merchant.id, updated_at: "2018-01-02")
      item_3 = create(:item, merchant_id: merchant.id, updated_at: "2018-01-01")
      item_4 = create(:item, merchant_id: merchant.id, updated_at: "2018-01-03")
      item_5 = create(:item, merchant_id: merchant.id, updated_at: "2018-01-04")

      updated_at = URI.encode(item_1.updated_at.to_formatted_s(:db))
      get "/api/v1/items/find_all?updated_at=#{updated_at}"

      filtered_items = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_items.count).to eq(2)
      expect(filtered_items.first["id"]).to eq(item_1.id)
      expect(filtered_items.last["id"]).to eq(item_3.id)
    end
    
  end
end