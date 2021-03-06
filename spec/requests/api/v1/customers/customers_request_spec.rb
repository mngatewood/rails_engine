require "rails_helper"

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    customers = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(customers.count).to eq(3)
  end

  it "can get a customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(customer["attributes"]["id"]).to eq(id)
  end
end