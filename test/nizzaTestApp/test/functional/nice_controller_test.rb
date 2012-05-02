require 'test_helper'

class NiceControllerTest < ActionController::TestCase
  test "should get simple" do
    get :simple
    assert_response :success
  end

  test "should get many" do
    get :many
    assert_response :success
  end

end
