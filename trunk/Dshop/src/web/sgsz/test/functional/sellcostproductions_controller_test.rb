require 'test_helper'

class SellcostproductionsControllerTest < ActionController::TestCase
  setup do
    @sellcostproduction = sellcostproductions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sellcostproductions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sellcostproduction" do
    assert_difference('Sellcostproduction.count') do
      post :create, sellcostproduction: { amount: @sellcostproduction.amount, color: @sellcostproduction.color, goodsname: @sellcostproduction.goodsname, pid: @sellcostproduction.pid, type: @sellcostproduction.type, unit: @sellcostproduction.unit }
    end

    assert_redirected_to sellcostproduction_path(assigns(:sellcostproduction))
  end

  test "should show sellcostproduction" do
    get :show, id: @sellcostproduction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sellcostproduction
    assert_response :success
  end

  test "should update sellcostproduction" do
    put :update, id: @sellcostproduction, sellcostproduction: { amount: @sellcostproduction.amount, color: @sellcostproduction.color, goodsname: @sellcostproduction.goodsname, pid: @sellcostproduction.pid, type: @sellcostproduction.type, unit: @sellcostproduction.unit }
    assert_redirected_to sellcostproduction_path(assigns(:sellcostproduction))
  end

  test "should destroy sellcostproduction" do
    assert_difference('Sellcostproduction.count', -1) do
      delete :destroy, id: @sellcostproduction
    end

    assert_redirected_to sellcostproductions_path
  end
end
