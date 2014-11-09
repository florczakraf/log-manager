require 'test_helper'

class ViolationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get filter" do
    get :filter
    assert_response :success
  end

end
