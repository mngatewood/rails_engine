class Api::V1::Items::MostRevenueController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.most_revenue(item_params[:quantity]))
  end

  private

  def item_params
    params.permit(:quantity)
  end

end
