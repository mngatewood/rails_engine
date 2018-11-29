class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: Invoice.total_revenue(params[:date]), 
      each_serializer: MerchantRevenueSerializer
  end

  private

  def merchant_params
    params.permit(:date)
  end

end