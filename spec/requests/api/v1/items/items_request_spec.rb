require "rails_helper"

describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items"

    items = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(items.count).to eq(3)
  end

  it "can get a item by its id" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item["attributes"]["id"].to_i).to eq(id)
  end
end