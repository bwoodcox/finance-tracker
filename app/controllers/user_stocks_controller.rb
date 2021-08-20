class UserStocksController < ApplicationController
  def create
    stock = Stock.db_lookup params[:ticker]
    if stock.blank?
      stock = Stock.lookup params[:ticker]
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.ticker} was successfully added to your portfolio."
    redirect_to my_portfolio_path
  end
end
