require 'test_helper'

class OrderdetailsControllerTest < ActionController::TestCase
  test "should get del" do
    get :del
    assert_response :success
  end

end
