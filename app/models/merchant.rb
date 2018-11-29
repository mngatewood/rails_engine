class Merchant < ApplicationRecord

  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.top_merchants_by_revenue(limit)
    Merchant.select("merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS total_revenue")
            .joins(invoices: [:invoice_items, :transactions])
            .where("transactions.result = ?", "success")
            .group(:id)
            .order("total_revenue desc")
            .limit(limit)
  end

end