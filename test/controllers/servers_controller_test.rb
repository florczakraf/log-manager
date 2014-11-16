require 'test_helper'

class ServersControllerTest < ActionController::TestCase
  test "should get all" do
    get :all
    assert_response :success
  end

  test "should get manage" do
    get :manage
    assert_response :success
  end

end
