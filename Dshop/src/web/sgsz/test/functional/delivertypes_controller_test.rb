require 'test_helper'

class DelivertypesControllerTest < ActionController::TestCase
  setup do
    @delivertype = delivertypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delivertypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivertype" do
    assert_difference('Delivertype.count') do
      post :create, delivertype: { amount: @delivertype.amount, discount: @delivertype.discount }
    end

    assert_redirected_to delivertype_path(assigns(:delivertype))
  end

  test "should show delivertype" do
    get :show, id: @delivertype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivertype
    assert_response :success
  end

  test "should update delivertype" do
    put :update, id: @delivertype, delivertype: { amount: @delivertype.amount, discount: @delivertype.discount }
    assert_redirected_to delivertype_path(assigns(:delivertype))
  end

  test "should destroy delivertype" do
    assert_difference('Delivertype.count', -1) do
      delete :destroy, id: @delivertype
    end

    assert_redirected_to delivertypes_path
  end
end
