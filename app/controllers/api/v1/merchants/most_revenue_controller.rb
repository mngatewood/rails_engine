class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.top_merchants_by_revenue(merchant_params[:quantity]))
  end

  private

  def merchant_params
    params.permit(:quantity)
  end



end