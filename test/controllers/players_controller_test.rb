require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test "should get all" do
    get :all
    assert_response :success
  end

  test "should get filter" do
    get :filter
    assert_response :success
  end

  test "should get ban" do
    get :ban
    assert_response :success
  end

  test "should get id" do
    get :id
    assert_response :success
  end

end
