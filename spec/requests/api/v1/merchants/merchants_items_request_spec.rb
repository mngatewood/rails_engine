require "rails_helper"

describe "Merchant items API" do
  it "returns a list of items for a merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_1_items = create_list(:item, 3, merchant_id: merchant_1.id)
    create_list(:item, 3, merchant_id: merchant_2.id)
    create_list(:item, 3, merchant_id: merchant_3.id)

    get "/api/v1/merchants/#{merchant_1.id}/items"

    merchant_items = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(merchant_items.count).to eq(3)
    expect(merchant_items.first["attributes"]["id"].to_i).to eq(merchant_1_items.first.id)
    expect(merchant_items.last["attributes"]["id"].to_i).to eq(merchant_1_items.last.id)
  end
end