class Merchant < ApplicationRecord

  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.total_revenue(date)
    Merchant.select('invoice_items.quantity * invoice_items.unit_price')
            .joins(:invoices)
            .joins(:invoice_items)
            .where('invoice_items.created_at = date')
  end

end