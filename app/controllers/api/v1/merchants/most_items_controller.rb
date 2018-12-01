class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.top_merchants_by_items_sold(params[:quantity]))
  end

  private

  def merchant_params
    params.permit(:quantity)
  end



end