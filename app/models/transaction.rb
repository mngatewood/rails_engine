class Transaction < ApplicationRecord

  validates_presence_of :credit_card_number, 
                        :credit_card_expiration, 
                        :result,
                        :invoice_id

  belongs_to :invoice
  
end