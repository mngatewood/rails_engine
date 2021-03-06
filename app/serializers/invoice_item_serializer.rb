class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer    
  attributes :id, :quantity, :unit_price, :invoice_id, :item_id
  attribute :unit_price do |invoice_item|
    (invoice_item.unit_price.round(2)/100.00).to_s
  end
end
