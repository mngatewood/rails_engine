require "rails_helper"

describe "Invoice Items finders" do
  describe "single finders" do

    it "finds a single invoice item by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_items = create_list(:invoice_item, 3, invoice: invoice, item: item)

      get "/api/v1/invoice_items/find?id=#{invoice_items.first.id}"

      invoice_item = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice_item["attributes"]["id"].to_i).to eq(invoice_items.first.id)
    end
    
    it "finds a single invoice item by quantity" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, quantity: 11, invoice: invoice, item: item)
      invoice_items = create_list(:invoice_item, 3, invoice: invoice, item: item)

      get "/api/v1/invoice_items/find?quantity=#{invoice_item_1.quantity}"

      invoice_item = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice_item["attributes"]["quantity"]).to eq(invoice_item_1.quantity)
    end

    it "finds a single invoice item by unit_price" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, unit_price: 11, invoice: invoice, item: item)
      invoice_items = create_list(:invoice_item, 3, invoice: invoice, item: item)

      get "/api/v1/invoice_items/find?unit_price=#{invoice_item_1.unit_price}"

      invoice_item = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice_item["attributes"]["unit_price"].to_f).to eq(invoice_item_1.unit_price)
    end

    it "finds a single invoice item by invoice id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, merchant: merchant, customer: customer)
      invoice_2 = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item)
      invoice_items = create_list(:invoice_item, 3, invoice: invoice_2, item: item)

      get "/api/v1/invoice_items/find?invoice_id=#{invoice_item_1.invoice_id}"

      invoice_item = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice_item["attributes"]["invoice_id"].to_i).to eq(invoice_item_1.invoice_id)
    end

    it "finds a single invoice item by item id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, invoice: invoice, item: item_1)
      invoice_items = create_list(:invoice_item, 3, invoice: invoice, item: item_2)

      get "/api/v1/invoice_items/find?item_id=#{invoice_item_1.item_id}"

      invoice_item = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice_item["attributes"]["item_id"].to_i).to eq(invoice_item_1.item_id)
    end

    it "finds a single invoice item by created_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, created_at: "2018-01-01T11:11:11.000Z", invoice: invoice, item: item)
      invoice_items = create_list(:invoice_item, 3, invoice: invoice, item: item)

      get "/api/v1/invoice_items/find?created_at=#{invoice_item_1.created_at}"

      invoice_item = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice_item["attributes"]["id"]).to eq(invoice_item_1.id)
    end

    it "finds a single invoice item by updated_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, updated_at: "2018-01-01T11:11:11.000Z", invoice: invoice, item: item)
      invoice_items = create_list(:invoice_item, 3, invoice: invoice, item: item)

      get "/api/v1/invoice_items/find?updated_at=#{invoice_item_1.updated_at}"

      invoice_item = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice_item["attributes"]["id"]).to eq(invoice_item_1.id)
    end

  end

  describe 'multi-finders' do

    it "finds all invoice items by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_items = create_list(:invoice_item, 3, invoice: invoice, item: item)

      get "/api/v1/invoice_items/find_all?id=#{invoice_items.first.id}"

      filtered_invoice_items = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoice_items.count).to eq(1)
      expect(filtered_invoice_items.first["attributes"]["id"].to_i).to eq(invoice_items.first.id)
    end
    
    it "finds all invoice items by quantity" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, invoice: invoice, item: item)
      invoice_items = create_list(:invoice_item, 3, quantity: 11, invoice: invoice, item: item)

      get "/api/v1/invoice_items/find_all?quantity=#{invoice_items.first.quantity}"

      filtered_invoice_items = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoice_items.count).to eq(3)
      expect(filtered_invoice_items.first["attributes"]["quantity"]).to eq(invoice_items.first.quantity)
    end

    it "finds all invoice items by unit_price" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, invoice: invoice, item: item)
      invoice_items = create_list(:invoice_item, 3, unit_price: 11, invoice: invoice, item: item)

      get "/api/v1/invoice_items/find_all?unit_price=#{invoice_items.first.unit_price}"

      filtered_invoice_items = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoice_items.count).to eq(3)
      expect(filtered_invoice_items.first["attributes"]["unit_price"].to_f).to eq(invoice_items.first.unit_price)
    end

    it "finds all invoice items by invoice id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, merchant: merchant, customer: customer)
      invoice_2 = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item)
      invoice_items = create_list(:invoice_item, 3, invoice: invoice_2, item: item)

      get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_items.first.invoice_id}"

      filtered_invoice_items = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoice_items.count).to eq(3)
      expect(filtered_invoice_items.first["attributes"]["invoice_id"].to_i).to eq(invoice_items.first.invoice_id)
    end

    it "finds all invoice items by item id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, invoice: invoice, item: item_1)
      invoice_items = create_list(:invoice_item, 3, invoice: invoice, item: item_2)

      get "/api/v1/invoice_items/find_all?item_id=#{invoice_items.first.item_id}"

      filtered_invoice_items = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoice_items.count).to eq(3)
      expect(filtered_invoice_items.first["attributes"]["item_id"].to_i).to eq(invoice_items.first.item_id)
    end

    it "finds all invoice items by created_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, invoice: invoice, item: item)
      invoice_items = create_list(:invoice_item, 3, created_at: "2018-01-01T11:11:11.000Z", invoice: invoice, item: item)

      get "/api/v1/invoice_items/find_all?created_at=#{invoice_items.first.created_at}"

      filtered_invoice_items = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoice_items.count).to eq(3)
      expect(filtered_invoice_items.first["attributes"]["id"]).to eq(invoice_items.first.id)
    end

    it "finds all invoice items by updated_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      item = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, invoice: invoice, item: item)
      invoice_items = create_list(:invoice_item, 3, updated_at: "2018-01-01T11:11:11.000Z", invoice: invoice, item: item)

      get "/api/v1/invoice_items/find_all?updated_at=#{invoice_items.first.updated_at}"

      filtered_invoice_items = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoice_items.count).to eq(3)
      expect(filtered_invoice_items.first["attributes"]["id"]).to eq(invoice_items.first.id)
    end

  end
end