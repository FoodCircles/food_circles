require 'test_helper'

class RaceControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
