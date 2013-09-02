require 'test_helper'

class OrderdetailsControllerTest < ActionController::TestCase
  setup do
    @orderdetail = orderdetails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orderdetails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orderdetail" do
    assert_difference('Orderdetail.count') do
      post :create, orderdetail: { additional: @orderdetail.additional, amount: @orderdetail.amount, barcode: @orderdetail.barcode, bundle: @orderdetail.bundle, cdate: @orderdetail.cdate, color: @orderdetail.color, discount: @orderdetail.discount, goodsname: @orderdetail.goodsname, hprice: @orderdetail.hprice, inprice: @orderdetail.inprice, oid: @orderdetail.oid, outprice: @orderdetail.outprice, pfprice: @orderdetail.pfprice, pid: @orderdetail.pid, ramount: @orderdetail.ramount, rbundle: @orderdetail.rbundle, remark: @orderdetail.remark, size: @orderdetail.size, status: @orderdetail.status, subtotal: @orderdetail.subtotal, unit: @orderdetail.unit, volume: @orderdetail.volume }
    end

    assert_redirected_to orderdetail_path(assigns(:orderdetail))
  end

  test "should show orderdetail" do
    get :show, id: @orderdetail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @orderdetail
    assert_response :success
  end

  test "should update orderdetail" do
    put :update, id: @orderdetail, orderdetail: { additional: @orderdetail.additional, amount: @orderdetail.amount, barcode: @orderdetail.barcode, bundle: @orderdetail.bundle, cdate: @orderdetail.cdate, color: @orderdetail.color, discount: @orderdetail.discount, goodsname: @orderdetail.goodsname, hprice: @orderdetail.hprice, inprice: @orderdetail.inprice, oid: @orderdetail.oid, outprice: @orderdetail.outprice, pfprice: @orderdetail.pfprice, pid: @orderdetail.pid, ramount: @orderdetail.ramount, rbundle: @orderdetail.rbundle, remark: @orderdetail.remark, size: @orderdetail.size, status: @orderdetail.status, subtotal: @orderdetail.subtotal, unit: @orderdetail.unit, volume: @orderdetail.volume }
    assert_redirected_to orderdetail_path(assigns(:orderdetail))
  end

  test "should destroy orderdetail" do
    assert_difference('Orderdetail.count', -1) do
      delete :destroy, id: @orderdetail
    end

    assert_redirected_to orderdetails_path
  end
end
