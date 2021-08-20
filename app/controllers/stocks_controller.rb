class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.lookup params[:stock]
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid stock symbol to search."
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a stock symbol to search."
        format.js { render partial: 'users/result' }
      end
    end
  end
end
