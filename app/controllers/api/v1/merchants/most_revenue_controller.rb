class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: Merchant.top_merchants_by_revenue(params[:quantity]),
      each_serializer: MerchantMostRevenueSerializer
  end

  private

  def merchant_params
    params.permit(:quantity)
  end



end