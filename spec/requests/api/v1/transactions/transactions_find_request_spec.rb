require "rails_helper"

describe "Transaction finders" do
  describe "single finders" do

    it "finds a single transaction by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transactions = create_list(:transaction, 3, invoice: invoice)

      get "/api/v1/transactions/find?id=#{transactions.first.id}"

      transaction = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(transaction["attributes"]["id"].to_i).to eq(transactions.first.id)
    end
    
    it "finds a single transaction by credit card number" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, invoice: invoice, credit_card_number: "4444444444444444")
      transactions = create_list(:transaction, 3, invoice: invoice)

      get "/api/v1/transactions/find?credit_card_number=#{transaction_1.credit_card_number}"

      item = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(item["attributes"]["credit_card_number"]).to eq(transaction_1.credit_card_number)
    end

    it "finds a single transaction by credit card expiration date" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, invoice: invoice, credit_card_expiration_date: "4444")
      transactions = create_list(:transaction, 3, invoice: invoice)

      get "/api/v1/transactions/find?credit_card_expiration_date=#{transaction_1.credit_card_expiration_date}"

      transaction = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(transaction["attributes"]["id"]).to eq(transaction_1.id)
    end

    it "finds a single transaction by result" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, invoice: invoice, result: "pending")
      transactions = create_list(:transaction, 3, invoice: invoice)

      get "/api/v1/transactions/find?result=#{transaction_1.result}"

      transaction = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(transaction["attributes"]["id"]).to eq(transaction_1.id)
    end

    it "finds a single transaction by invoice id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, merchant: merchant, customer: customer)
      invoice_2 = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, invoice: invoice_1)
      transactions = create_list(:transaction, 3, invoice: invoice_2)

      get "/api/v1/transactions/find?invoice_id=#{transactions.first.invoice_id}"

      transaction = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(transaction["attributes"]["id"]).to eq(transactions.first.id)
    end

    it "finds a single transaction by created_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, created_at: "2018-01-01T11:11:11.000Z", invoice: invoice)
      transactions = create_list(:transaction, 3, invoice: invoice)

      get "/api/v1/transactions/find?created_at=#{transaction_1.created_at}"

      transaction = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(transaction["attributes"]["id"].to_i).to eq(transaction_1.id)
    end

    it "finds a single invoice by updated_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, updated_at: "2018-01-01T11:11:11.000Z", invoice: invoice)
      transactions = create_list(:transaction, 3, invoice: invoice)

      get "/api/v1/transactions/find?updated_at=#{transaction_1.updated_at}"

      transaction = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(transaction["attributes"]["id"].to_i).to eq(transaction_1.id)
    end

  end

  describe 'multi-finders' do

    it "finds all transactions by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transactions = create_list(:transaction, 3, invoice: invoice)

      get "/api/v1/transactions/find_all?id=#{transactions.first.id}"

      filtered_transactions = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_transactions.count).to eq(1)
      expect(filtered_transactions.first["attributes"]["id"].to_i).to eq(transactions.first.id)
    end
    
    it "finds all transactions by credit card number" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, invoice: invoice, credit_card_number: "4444444444444444")
      transactions = create_list(:transaction, 3, invoice: invoice)

      get "/api/v1/transactions/find_all?credit_card_number=#{transactions.first.credit_card_number}"

      filtered_transactions = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_transactions.count).to eq(3)
      expect(filtered_transactions.first["attributes"]["credit_card_number"]).to eq(transactions.first.credit_card_number)
    end

    it "finds all transactions by credit card expiration date" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, invoice: invoice, credit_card_expiration_date: "4444")
      transactions = create_list(:transaction, 3, invoice: invoice)

      get "/api/v1/transactions/find_all?credit_card_expiration_date=#{transactions.first.credit_card_expiration_date}"

      filtered_transactions = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_transactions.count).to eq(3)
      expect(filtered_transactions.first["attributes"]["id"]).to eq(transactions.first.id)
    end

    it "finds all transactions by result" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, invoice: invoice, result: "pending")
      transactions = create_list(:transaction, 3, invoice: invoice)

      get "/api/v1/transactions/find_all?result=#{transactions.first.result}"

      filtered_transactions = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_transactions.count).to eq(3)
      expect(filtered_transactions.first["attributes"]["id"]).to eq(transactions.first.id)
    end

    it "finds all transactions by invoice id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, merchant: merchant, customer: customer)
      invoice_2 = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, invoice: invoice_1)
      transactions = create_list(:transaction, 3, invoice: invoice_2)

      get "/api/v1/transactions/find_all?invoice_id=#{transactions.first.invoice_id}"

      filtered_transactions = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_transactions.count).to eq(3)
      expect(filtered_transactions.first["attributes"]["id"]).to eq(transactions.first.id)
    end

    it "finds all transactions by created_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, invoice: invoice)
      transactions = create_list(:transaction, 3, created_at: "2018-01-01T11:11:11.000Z", invoice: invoice)

      get "/api/v1/transactions/find_all?created_at=#{transactions.first.created_at}"

      filtered_transactions = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_transactions.count).to eq(3)
      expect(filtered_transactions.first["attributes"]["id"].to_i).to eq(transactions.first.id)
    end

    it "finds a single invoice by updated_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      transaction_1 = create(:transaction, invoice: invoice)
      transactions = create_list(:transaction, 3, updated_at: "2018-01-01T11:11:11.000Z", invoice: invoice)

      get "/api/v1/transactions/find_all?updated_at=#{transactions.first.updated_at}"

      filtered_transactions = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(filtered_transactions.count).to eq(3)
      expect(filtered_transactions.first["attributes"]["id"].to_i).to eq(transactions.first.id)
    end

  end
end