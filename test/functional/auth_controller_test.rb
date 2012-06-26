require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :redirect
    assert_redirected_to :action => "login"
  end

  test "should get index redirect to login without session" do
    get :index
    assert_response :redirect
    assert_redirected_to :action => "login"
  end

end
