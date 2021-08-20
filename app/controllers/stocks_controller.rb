class StocksController < ApplicationController
  def search
    @stock = Stock.lookup params[:stock]
    render json: @stock
  end
end
