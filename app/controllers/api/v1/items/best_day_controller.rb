class Api::V1::Items::BestDayController < ApplicationController

  def show
    render json: ItemBestDaySerializer.new(Invoice.best_day(params[:id]))
  end
  
end