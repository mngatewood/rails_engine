class Invoice < ApplicationRecord

  validates_presence_of :status, 
                        :merchant_id, 
                        :customer_id

  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.total_revenue(date)
    Invoice.select("SUM(invoice_items.unit_price*invoice_items.quantity) AS total_revenue")
           .joins(:transactions, :invoice_items)
           .where("transactions.result = ?", "success")
           .where("invoices.created_at = ?", date)
           .to_a.first.total_revenue.to_f.round(2)
  end

end