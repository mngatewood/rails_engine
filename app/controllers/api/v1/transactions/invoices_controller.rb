class Api::V1::Transactions::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.joins(:transactions)
                                              .where(transactions: { id: params[:transaction_id] }))
  end
end