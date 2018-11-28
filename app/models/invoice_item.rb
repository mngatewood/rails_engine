class InvoiceItem < ApplicationRecord

  validates_presence_of :quantity, 
                        :unit_price, 
                        :invoice_id, 
                        :item_id

  belongs_to :invoice
  belongs_to :item

end