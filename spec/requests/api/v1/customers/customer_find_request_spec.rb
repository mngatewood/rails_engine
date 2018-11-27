require 'rails_helper'

describe 'Customer finders' do
  describe 'single finder' do

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
end