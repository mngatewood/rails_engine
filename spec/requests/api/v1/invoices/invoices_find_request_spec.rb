require "rails_helper"
require "URI"

describe "Invoices finders" do
  describe "single finders" do

    it "finds a single invoice by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find?id=#{invoices.first.id}"

      invoice = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice["attributes"]["id"].to_i).to eq(invoices.first.id)
    end
    
    it "finds a single invoice by status" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, status: 'pending', merchant_id: merchant.id, customer_id: customer.id)
      invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find?name=#{invoice_1.status}"

      item = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(item["attributes"]["status"]).to eq(invoice_1.status)
    end

    it "finds a single invoice by merchant_id" do
      customer = create(:customer)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
      invoices = create_list(:invoice, 3, merchant_id: merchant_2.id, customer_id: customer.id)

      get "/api/v1/invoices/find?merchant_id=#{invoice_1.merchant_id}"

      invoice = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice["attributes"]["id"]).to eq(invoice_1.id)
    end

    it "finds a single invoice by customer_id" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      merchant = create(:merchant)
      invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id)
      invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer_2.id)

      get "/api/v1/invoices/find?customer_id=#{invoice_1.customer_id}"

      invoice = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice["attributes"]["id"]).to eq(invoice_1.id)
    end

    it "finds a single invoice by created_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, created_at: "2018-01-01T11:11:11.000Z", merchant_id: merchant.id, customer_id: customer.id)
      invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find?created_at=#{invoice_1.created_at}"

      invoice = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice["attributes"]["id"].to_i).to eq(invoice_1.id)
    end

    it "finds a single invoice by updated_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, updated_at: "2018-01-01T11:11:11.000Z", merchant_id: merchant.id, customer_id: customer.id)
      invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find?updated_at=#{invoice_1.updated_at}"

      invoice = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice["attributes"]["id"].to_i).to eq(invoice_1.id)
    end

  end

  describe 'multi-finders' do

    it "finds all invoices by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find_all?id=#{invoices.first.id}"

      filtered_invoices = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoices.count).to eq(1)
      expect(filtered_invoices.first["attributes"]["id"]).to eq(invoices.first.id)
    end
    
    it "finds all invoices by status" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, status: 'pending', merchant_id: merchant.id, customer_id: customer.id)
      invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find_all?status=#{invoices.first.status}"

      filtered_invoices = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoices.count).to eq(3)
      expect(filtered_invoices.first["attributes"]["id"]).to eq(invoices.first.id)
    end

    it "finds all invoices by merchant_id" do
      customer = create(:customer)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
      invoices = create_list(:invoice, 3, merchant_id: merchant_2.id, customer_id: customer.id)

      get "/api/v1/invoices/find_all?merchant_id=#{invoices.first.merchant_id}"

      filtered_invoices = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoices.count).to eq(3)
      expect(filtered_invoices.first["attributes"]["id"]).to eq(invoices.first.id)
    end

    it "finds all invoices by customer_id" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      merchant = create(:merchant)
      invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id)
      invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer_2.id)

      get "/api/v1/invoices/find_all?customer_id=#{invoices.first.customer_id}"

      filtered_invoices = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoices.count).to eq(3)
      expect(filtered_invoices.first["attributes"]["id"]).to eq(invoices.first.id)
    end

    it "finds all invoices by created_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, created_at: "2018-01-01T11:11:11.000Z", merchant_id: merchant.id, customer_id: customer.id)
      invoice_2 = create(:invoice, created_at: "2018-01-02T11:11:11.000Z", merchant_id: merchant.id, customer_id: customer.id)
      invoice_3 = create(:invoice, created_at: "2018-01-02T11:11:11.000Z", merchant_id: merchant.id, customer_id: customer.id)
      invoice_4 = create(:invoice, created_at: "2018-01-02T11:11:11.000Z", merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find_all?created_at=#{invoice_2.created_at}"

      filtered_invoices = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoices.count).to eq(3)
      expect(filtered_invoices.first["attributes"]["id"].to_i).to eq(invoice_2.id)
    end

    it "finds all invoices by updated_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, updated_at: "2018-01-01T11:11:11.000Z", merchant_id: merchant.id, customer_id: customer.id)
      invoice_2 = create(:invoice, updated_at: "2018-01-02T11:11:11.000Z", merchant_id: merchant.id, customer_id: customer.id)
      invoice_3 = create(:invoice, updated_at: "2018-01-02T11:11:11.000Z", merchant_id: merchant.id, customer_id: customer.id)
      invoice_4 = create(:invoice, updated_at: "2018-01-02T11:11:11.000Z", merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find_all?updated_at=#{invoice_2.updated_at}"

      filtered_invoices = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_invoices.count).to eq(3)
      expect(filtered_invoices.first["attributes"]["id"].to_i).to eq(invoice_2.id)
    end

  end
end