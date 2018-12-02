class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.customer_favorite(customer_params[:id]))
  end

  private

  def customer_params
    params.permit(:id)
  end

end