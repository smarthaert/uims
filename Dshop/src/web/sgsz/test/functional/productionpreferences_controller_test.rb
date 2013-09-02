require 'test_helper'

class ProductionpreferencesControllerTest < ActionController::TestCase
  setup do
    @productionpreference = productionpreferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:productionpreferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create productionpreference" do
    assert_difference('Productionpreference.count') do
      post :create, productionpreference: { amount: @productionpreference.amount, color: @productionpreference.color, custstate: @productionpreference.custstate, goodsname: @productionpreference.goodsname, pid: @productionpreference.pid }
    end

    assert_redirected_to productionpreference_path(assigns(:productionpreference))
  end

  test "should show productionpreference" do
    get :show, id: @productionpreference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @productionpreference
    assert_response :success
  end

  test "should update productionpreference" do
    put :update, id: @productionpreference, productionpreference: { amount: @productionpreference.amount, color: @productionpreference.color, custstate: @productionpreference.custstate, goodsname: @productionpreference.goodsname, pid: @productionpreference.pid }
    assert_redirected_to productionpreference_path(assigns(:productionpreference))
  end

  test "should destroy productionpreference" do
    assert_difference('Productionpreference.count', -1) do
      delete :destroy, id: @productionpreference
    end

    assert_redirected_to productionpreferences_path
  end
end
