require 'test_helper'

class TrucksControllerTest < ActionController::TestCase
  test "should get by_license" do
    get :by_license
    assert_response :success
  end

end
