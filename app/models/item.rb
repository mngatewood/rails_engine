class Item < ApplicationRecord

  validates_presence_of :name, 
                        :description, 
                        :unit_price, 
                        :merchant_id

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(limit)
    Item.select("items.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue")
        .joins(:invoice_items, invoices: :transactions)
        .where("transactions.result = ?", "success")
        .group(:id)
        .order("revenue desc")
        .limit(limit)
  end

  def self.most_sold(limit)
    Item.select("items.*, invoice_items.quantity AS items_sold")
        .joins(:invoice_items, invoices: :transactions)
        .where("transactions.result = ?", "success")
        .group(:id, :items_sold)
        .order("items_sold desc")
        .limit(limit)
  end

end