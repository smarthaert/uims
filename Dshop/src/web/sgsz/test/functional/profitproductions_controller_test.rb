require 'test_helper'

class ProfitproductionsControllerTest < ActionController::TestCase
  setup do
    @profitproduction = profitproductions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profitproductions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profitproduction" do
    assert_difference('Profitproduction.count') do
      post :create, profitproduction: { color: @profitproduction.color, goodsname: @profitproduction.goodsname, pid: @profitproduction.pid, profit: @profitproduction.profit }
    end

    assert_redirected_to profitproduction_path(assigns(:profitproduction))
  end

  test "should show profitproduction" do
    get :show, id: @profitproduction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profitproduction
    assert_response :success
  end

  test "should update profitproduction" do
    put :update, id: @profitproduction, profitproduction: { color: @profitproduction.color, goodsname: @profitproduction.goodsname, pid: @profitproduction.pid, profit: @profitproduction.profit }
    assert_redirected_to profitproduction_path(assigns(:profitproduction))
  end

  test "should destroy profitproduction" do
    assert_difference('Profitproduction.count', -1) do
      delete :destroy, id: @profitproduction
    end

    assert_redirected_to profitproductions_path
  end
end
