require "test_helper"

class StocksControllerTest < ActionDispatch::IntegrationTest
  test "should get search_stock" do
    get stocks_search_stock_url
    assert_response :success
  end
end
