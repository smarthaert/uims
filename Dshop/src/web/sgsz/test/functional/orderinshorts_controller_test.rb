require 'test_helper'

class OrderinshortsControllerTest < ActionController::TestCase
  setup do
    @orderinshort = orderinshorts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orderinshorts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orderinshort" do
    assert_difference('Orderinshort.count') do
      post :create, orderinshort: { amount: @orderinshort.amount, cdate: @orderinshort.cdate, custname: @orderinshort.custname, custtel: @orderinshort.custtel, oid: @orderinshort.oid, pid: @orderinshort.pid, stockamount: @orderinshort.stockamount }
    end

    assert_redirected_to orderinshort_path(assigns(:orderinshort))
  end

  test "should show orderinshort" do
    get :show, id: @orderinshort
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @orderinshort
    assert_response :success
  end

  test "should update orderinshort" do
    put :update, id: @orderinshort, orderinshort: { amount: @orderinshort.amount, cdate: @orderinshort.cdate, custname: @orderinshort.custname, custtel: @orderinshort.custtel, oid: @orderinshort.oid, pid: @orderinshort.pid, stockamount: @orderinshort.stockamount }
    assert_redirected_to orderinshort_path(assigns(:orderinshort))
  end

  test "should destroy orderinshort" do
    assert_difference('Orderinshort.count', -1) do
      delete :destroy, id: @orderinshort
    end

    assert_redirected_to orderinshorts_path
  end
end
