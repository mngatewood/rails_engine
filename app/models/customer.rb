class Customer < ApplicationRecord

  validates_presence_of :first_name, :last_name

  has_many :invoices

  def self.merchant_favorite(merchant_id)
    Customer.select("customers.*, COUNT(transactions.id) AS sales")
            .joins(invoices: :transactions)
            .where(transactions: {result: 'success'})
            .where(invoices: {merchant_id: merchant_id})
            .group(:id)
            .order("sales desc")
            .limit(1)
            .first
  end

end