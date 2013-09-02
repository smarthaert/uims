require 'test_helper'

class ProfitcustomersControllerTest < ActionController::TestCase
  setup do
    @profitcustomer = profitcustomers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profitcustomers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profitcustomer" do
    assert_difference('Profitcustomer.count') do
      post :create, profitcustomer: { custname: @profitcustomer.custname, custtel: @profitcustomer.custtel, profit: @profitcustomer.profit }
    end

    assert_redirected_to profitcustomer_path(assigns(:profitcustomer))
  end

  test "should show profitcustomer" do
    get :show, id: @profitcustomer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profitcustomer
    assert_response :success
  end

  test "should update profitcustomer" do
    put :update, id: @profitcustomer, profitcustomer: { custname: @profitcustomer.custname, custtel: @profitcustomer.custtel, profit: @profitcustomer.profit }
    assert_redirected_to profitcustomer_path(assigns(:profitcustomer))
  end

  test "should destroy profitcustomer" do
    assert_difference('Profitcustomer.count', -1) do
      delete :destroy, id: @profitcustomer
    end

    assert_redirected_to profitcustomers_path
  end
end
