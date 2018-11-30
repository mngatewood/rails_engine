class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    if(params[:id] && params[:date])
      render json: Merchant.total_revenue_for_date(merchant_params[:id], 
                                                   merchant_params[:date]),
        each_serializer: MerchantRevenueSerializer
    elsif(params[:id])
      render json: Merchant.total_revenue(merchant_params[:id]),
        each_serializer: MerchantRevenueSerializer
    elsif(params[:date])
      render json: Invoice.total_revenue(merchant_params[:date]), 
        each_serializer: MerchantRevenueSerializer
    end
  end

  private

  def merchant_params
    params.permit(:id, :date)
  end

end