class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    if(params[:id] && params[:date])
      render json: MerchantRevenueSerializer.new(Merchant.total_revenue_for_date(merchant_params[:id], 
                                                                          merchant_params[:date]))
    elsif(params[:id])
      render json: MerchantRevenueSerializer.new(Merchant.total_revenue(merchant_params[:id]))
    elsif(params[:date])
      render json: MerchantRevenueSerializer.new(Invoice.total_revenue(merchant_params[:date]))
    end
  end

  private

  def merchant_params
    params.permit(:id, :date)
  end

end