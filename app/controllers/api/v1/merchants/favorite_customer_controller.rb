class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    render json: Customer.merchant_favorite(merchant_params[:id])
  end

  private

  def merchant_params
    params.permit(:id)
  end

end