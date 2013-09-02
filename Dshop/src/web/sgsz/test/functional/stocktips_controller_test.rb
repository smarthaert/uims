require 'test_helper'

class StocktipsControllerTest < ActionController::TestCase
  setup do
    @stocktip = stocktips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stocktips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stocktip" do
    assert_difference('Stocktip.count') do
      post :create, stocktip: { amount: @stocktip.amount, baseline: @stocktip.baseline, color: @stocktip.color, goodsname: @stocktip.goodsname, pid: @stocktip.pid }
    end

    assert_redirected_to stocktip_path(assigns(:stocktip))
  end

  test "should show stocktip" do
    get :show, id: @stocktip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stocktip
    assert_response :success
  end

  test "should update stocktip" do
    put :update, id: @stocktip, stocktip: { amount: @stocktip.amount, baseline: @stocktip.baseline, color: @stocktip.color, goodsname: @stocktip.goodsname, pid: @stocktip.pid }
    assert_redirected_to stocktip_path(assigns(:stocktip))
  end

  test "should destroy stocktip" do
    assert_difference('Stocktip.count', -1) do
      delete :destroy, id: @stocktip
    end

    assert_redirected_to stocktips_path
  end
end
