require 'test_helper'

class AlertCreationAndCheckTest < ActionDispatch::IntegrationTest
  
  setup do
    @stock = stocks(:schlumberger)
  end

  test "user_not_logged_in_can_create_an_alert" do
    get stock_url(@stock)
    assert_response :success
    assert_select "div.panel-heading", "Schlumberger"
    
    assert_difference('Alert.count', +1) do
      post '/alerts', params: { alert: { contact: 'my@email.com', stock_id: @stock.id, target_value: 90 } }
      assert_response :success
    end
    
  end
end
