class Api::V1::InvoiceItems::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.joins(:invoice_items)
                                        .where(invoice_items: { id: params[:invoice_item_id] }))
  end
end