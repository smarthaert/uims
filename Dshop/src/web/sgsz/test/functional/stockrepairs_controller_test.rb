require 'test_helper'

class StockrepairsControllerTest < ActionController::TestCase
  setup do
    @stockrepair = stockrepairs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stockrepairs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stockrepair" do
    assert_difference('Stockrepair.count') do
      post :create, stockrepair: { amount: @stockrepair.amount, color: @stockrepair.color, goodsname: @stockrepair.goodsname, pid: @stockrepair.pid, unit: @stockrepair.unit, volume: @stockrepair.volume }
    end

    assert_redirected_to stockrepair_path(assigns(:stockrepair))
  end

  test "should show stockrepair" do
    get :show, id: @stockrepair
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stockrepair
    assert_response :success
  end

  test "should update stockrepair" do
    put :update, id: @stockrepair, stockrepair: { amount: @stockrepair.amount, color: @stockrepair.color, goodsname: @stockrepair.goodsname, pid: @stockrepair.pid, unit: @stockrepair.unit, volume: @stockrepair.volume }
    assert_redirected_to stockrepair_path(assigns(:stockrepair))
  end

  test "should destroy stockrepair" do
    assert_difference('Stockrepair.count', -1) do
      delete :destroy, id: @stockrepair
    end

    assert_redirected_to stockrepairs_path
  end
end
