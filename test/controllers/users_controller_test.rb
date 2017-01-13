require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers 
 
  test "non signed in user cannot access a user page" do
    get user_path(users(:bob))
    assert_response :redirect 
  end

  test "signed in user can access it's page" do
    sign_in users(:bob)
    get user_path(users(:bob))
    assert_response :success
  end

  test "signed in user cannot access another user's page" do
    sign_in users(:bob)
    get user_path(users(:alice))
    assert_response :redirect
  end

  test "access to an unkown user page should redirect" do
    sign_in users(:bob)
    get user_path(id: 129823728) #, params: { id: 'unknown_user' }
    assert_response :redirect  
  end  
end
