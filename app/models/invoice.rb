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
    Invoice.select("SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue")
           .joins(:transactions, :invoice_items)
           .where("transactions.result = ?", "success")
           .where("invoices.created_at = ?", date)
           .to_a.first
  end

  def self.top_invoices_by_revenue(limit)
    Invoice.select("invoices.*, SUM(invoice_items.unit_price*invoice_items.quantity)::FLOAT AS total_revenue")
            .joins(:invoice_items, :transactions)
            .where("transactions.result = ?", "success")
            .group(:id)
            .order("total_revenue desc")
            .limit(limit)
  end

  def self.top_invoices_by_items_sold(limit)
    Invoice.select("invoices.*, invoice_items.quantity AS items_sold")
            .joins(:invoice_items, :transactions)
            .where("transactions.result = ?", "success")
            .group(:id, :items_sold)
            .order("items_sold desc")
            .limit(limit)
  end

  def self.best_day(item_id)
    Invoice.select("invoices.created_at::DATE AS date, SUM(invoice_items.quantity) AS sales")
            .joins(:invoice_items, :transactions, :items)
            .where(transactions: { result: 'success' })
            .where(items: {id: item_id})
            .group(:date)
            .order("sales desc, date desc")
            .limit(1)
            .first
  end

end