require 'rails_helper'

describe 'Customer finders' do
  describe 'single finders' do

    it "finds a single customer by id" do
      customers = create_list(:customer, 3)

      get "/api/v1/customers/find?id=#{customers.first.id}"

      customer = JSON.parse(response.body)
      expect(response).to be_successful
      expect(customer["id"]).to eq(customers.first.id)
    end
    
    it "finds a single customer by first name" do
      customers = create_list(:customer, 3)

      get "/api/v1/customers/find?first_name=#{customers.first.first_name}"

      customer = JSON.parse(response.body)
      expect(response).to be_successful
      expect(customer["first_name"]).to eq(customers.first.first_name)
    end
    
    it "finds a single customer by last name" do
      customers = create_list(:customer, 3)

      get "/api/v1/customers/find?last_name=#{customers.first.last_name}"

      customer = JSON.parse(response.body)
      expect(response).to be_successful
      expect(customer["last_name"]).to eq(customers.first.last_name)
    end
    
    xit "finds a single customer by created_at" do
      customers = create_list(:customer, 3)

      get "/api/v1/customers/find?created_at=#{customers.first.created_at}"

      customer = JSON.parse(response.body)
      expect(response).to be_successful
      expect(customer["created_at"]).to eq(customers.first.created_at)
    end
    
    xit "finds a single customer by updated_at" do
      customers = create_list(:customer, 3)

      get "/api/v1/customers/find?updated_at=#{customers.first.updated_at}"

      customer = JSON.parse(response.body)
      expect(response).to be_successful
      expect(customer["updated_at"]).to eq(customers.first.updated_at)
    end
    
  end

  describe 'multi-finders' do

    it "finds all customers by id" do
      customers = create_list(:customer, 3)

      get "/api/v1/customers/find_all?id=#{customers.first.id}"

      filtered_customers = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_customers.first["id"]).to eq(customers.first.id)
    end
    
    it "finds all customers by first name" do
      customer_1 = create(:customer, first_name: "David")
      customer_2 = create(:customer, first_name: "John")
      customer_3 = create(:customer, first_name: "David")
      customer_3 = create(:customer, first_name: "Sue")
      customer_3 = create(:customer, first_name: "Mike")

      get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

      filtered_customers = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_customers.count).to eq(2)
      expect(filtered_customers.first["first_name"]).to eq(customer_1.first_name)
      expect(filtered_customers.last["first_name"]).to eq(customer_1.first_name)
    end
    
    it "finds all customers by last name" do
      customer_1 = create(:customer, last_name: "Jones")
      customer_2 = create(:customer, last_name: "Davis")
      customer_3 = create(:customer, last_name: "Jones")
      customer_3 = create(:customer, last_name: "Anderson")
      customer_3 = create(:customer, last_name: "Johnson")

      get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"

      filtered_customers = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_customers.count).to eq(2)
      expect(filtered_customers.first["last_name"]).to eq(customer_1.last_name)
      expect(filtered_customers.last["last_name"]).to eq(customer_1.last_name)
    end
    
    xit "finds a all customers by created_at" do
      customer_1 = create(:customer, created_at: "2018-01-01")
      customer_2 = create(:customer, created_at: "2018-01-02")
      customer_3 = create(:customer, created_at: "2018-01-01")
      customer_4 = create(:customer, created_at: "2018-01-03")
      customer_5 = create(:customer, created_at: "2018-01-04")

      get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

      filtered_customers = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_customers.count).to eq(2)
      expect(filtered_customers.first["created_at"]).to eq(customer_1.created_at)
      expect(filtered_customers.last["created_at"]).to eq(customer_1.created_at)
    end
    
    xit "finds a all customers by updated_at" do
      customer_1 = create(:customer, updated_at: "2018-01-01")
      customer_2 = create(:customer, updated_at: "2018-01-02")
      customer_3 = create(:customer, updated_at: "2018-01-01")
      customer_4 = create(:customer, updated_at: "2018-01-03")
      customer_5 = create(:customer, updated_at: "2018-01-04")

      get "/api/v1/customers/find_all?updated_at=#{customer_1.updated_at}"

      filtered_customers = JSON.parse(response.body)
      expect(response).to be_successful
      expect(filtered_customers.count).to eq(2)
      expect(filtered_customers.first["updated_at"]).to eq(customer_1.updated_at)
      expect(filtered_customers.last["updated_at"]).to eq(customer_1.updated_at)
    end
    
  end
end