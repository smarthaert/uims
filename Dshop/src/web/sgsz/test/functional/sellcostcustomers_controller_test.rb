require 'test_helper'

class SellcostcustomersControllerTest < ActionController::TestCase
  setup do
    @sellcostcustomer = sellcostcustomers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sellcostcustomers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sellcostcustomer" do
    assert_difference('Sellcostcustomer.count') do
      post :create, sellcostcustomer: { amount: @sellcostcustomer.amount, cname: @sellcostcustomer.cname, tel: @sellcostcustomer.tel, type: @sellcostcustomer.type, unit: @sellcostcustomer.unit }
    end

    assert_redirected_to sellcostcustomer_path(assigns(:sellcostcustomer))
  end

  test "should show sellcostcustomer" do
    get :show, id: @sellcostcustomer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sellcostcustomer
    assert_response :success
  end

  test "should update sellcostcustomer" do
    put :update, id: @sellcostcustomer, sellcostcustomer: { amount: @sellcostcustomer.amount, cname: @sellcostcustomer.cname, tel: @sellcostcustomer.tel, type: @sellcostcustomer.type, unit: @sellcostcustomer.unit }
    assert_redirected_to sellcostcustomer_path(assigns(:sellcostcustomer))
  end

  test "should destroy sellcostcustomer" do
    assert_difference('Sellcostcustomer.count', -1) do
      delete :destroy, id: @sellcostcustomer
    end

    assert_redirected_to sellcostcustomers_path
  end
end
