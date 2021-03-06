class Merchant < ApplicationRecord

  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.top_merchants_by_revenue(limit)
    Merchant.select("merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue")
            .joins(invoices: [:invoice_items, :transactions])
            .where("transactions.result = ?", "success")
            .group(:id)
            .order("revenue desc")
            .limit(limit)
  end

  def self.top_merchants_by_items_sold(limit)
    Merchant.select("merchants.*, invoice_items.quantity AS items_sold")
            .joins(invoices: [:invoice_items, :transactions])
            .where("transactions.result = ?", "success")
            .group(:id, :items_sold)
            .order("items_sold desc")
            .limit(limit)
  end

  def self.total_revenue(merchant_id)
    Merchant.select("SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue")
            .joins(invoices: [:invoice_items, :transactions])
            .where(transactions: { result: 'success' })
            .where(merchants: { id: merchant_id})
            .to_a.first
  end

  def self.total_revenue_for_date(merchant_id, date)
    Merchant.select("SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue")
            .joins(invoices: [:invoice_items, :transactions])
            .where(transactions: { result: 'success' })
            .where(merchants: { id: merchant_id})
            .where("invoices.created_at::DATE = ?", date[0..9])
            .to_a.first
  end

  def self.customer_favorite(customer_id)
    Merchant.select("merchants.*, COUNT(transactions.id) AS sales")
            .joins(invoices: :transactions)
            .where(transactions: {result: 'success'})
            .where(invoices: {customer_id: customer_id})
            .group(:id)
            .order("sales desc")
            .limit(1)
            .first
  end


end