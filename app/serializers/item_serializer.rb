class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :merchant_id
  attribute :unit_price do |item|
    (item.unit_price.round(2)/100.00).to_s
  end
end
