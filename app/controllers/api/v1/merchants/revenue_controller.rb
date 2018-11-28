class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: Merchant.total_revenue(params[:date])
  end

  private

  def merchant_params
    params.permit(:date)
  end

end