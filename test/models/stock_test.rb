require 'test_helper'

class StockTest < ActiveSupport::TestCase
  setup do
  end

  test "New stock has a stock_live_info object attached at creation" do
    @stock = Stock.new
    assert_not_nil @stock.stock_live_info
  end

end
