require 'test_helper'

class ProfitshippersControllerTest < ActionController::TestCase
  setup do
    @profitshipper = profitshippers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profitshippers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profitshipper" do
    assert_difference('Profitshipper.count') do
      post :create, profitshipper: { amount: @profitshipper.amount, profit: @profitshipper.profit, sname: @profitshipper.sname, tel: @profitshipper.tel, volume: @profitshipper.volume }
    end

    assert_redirected_to profitshipper_path(assigns(:profitshipper))
  end

  test "should show profitshipper" do
    get :show, id: @profitshipper
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profitshipper
    assert_response :success
  end

  test "should update profitshipper" do
    put :update, id: @profitshipper, profitshipper: { amount: @profitshipper.amount, profit: @profitshipper.profit, sname: @profitshipper.sname, tel: @profitshipper.tel, volume: @profitshipper.volume }
    assert_redirected_to profitshipper_path(assigns(:profitshipper))
  end

  test "should destroy profitshipper" do
    assert_difference('Profitshipper.count', -1) do
      delete :destroy, id: @profitshipper
    end

    assert_redirected_to profitshippers_path
  end
end
