class Invoice < ApplicationRecord

  validates_presence_of :status, :merchant_id, :customer_id

  belongs_to :merchant
  belongs_to :customer

end