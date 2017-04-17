require 'test_helper'

class ApiTest < ActionDispatch::IntegrationTest
  setup do
    @alice = users(:alice)
  end
  
  test "POST /sign_in_token" do
    post '/api/sign_in_token'
    assert_response 404
    post '/api/sign_in_token', params: { email: 'nonuser@email.com' }
    assert_response 404
    post '/api/sign_in_token', params: { email: @alice.email, password: 'badpassword' }
    assert_response 401
    post '/api/sign_in_token', params: { email: @alice.email, password: 'goodpassword' }
    assert_response 200
  end
  
  test "GET /api/users/me" do
    get '/api/users/me'
    assert_response 302
    get '/api/users/me', headers: { token: 'faketoken' }
    assert_response 302
    # Login for real
    post '/api/sign_in_token', params: { email: @alice.email, password: 'goodpassword' }
    assert_response 200
    json = JSON.parse(response.body)
    
    get '/api/users/me', headers: { token: json["token"] }
    assert_response 200
  end
end

