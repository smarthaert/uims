require 'test_helper'

class AfterselldetailsControllerTest < ActionController::TestCase
  setup do
    @afterselldetail = afterselldetails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:afterselldetails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create afterselldetail" do
    assert_difference('Afterselldetail.count') do
      post :create, afterselldetail: { additional: @afterselldetail.additional, amount: @afterselldetail.amount, barcode: @afterselldetail.barcode, bundle: @afterselldetail.bundle, cdate: @afterselldetail.cdate, color: @afterselldetail.color, discount: @afterselldetail.discount, goodsname: @afterselldetail.goodsname, hprice: @afterselldetail.hprice, inprice: @afterselldetail.inprice, outprice: @afterselldetail.outprice, pfprice: @afterselldetail.pfprice, pid: @afterselldetail.pid, ramount: @afterselldetail.ramount, rbundle: @afterselldetail.rbundle, remark: @afterselldetail.remark, size: @afterselldetail.size, status: @afterselldetail.status, stid: @afterselldetail.stid, stname: @afterselldetail.stname, subtotal: @afterselldetail.subtotal, tid: @afterselldetail.tid, type: @afterselldetail.type, unit: @afterselldetail.unit, volume: @afterselldetail.volume }
    end

    assert_redirected_to afterselldetail_path(assigns(:afterselldetail))
  end

  test "should show afterselldetail" do
    get :show, id: @afterselldetail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @afterselldetail
    assert_response :success
  end

  test "should update afterselldetail" do
    put :update, id: @afterselldetail, afterselldetail: { additional: @afterselldetail.additional, amount: @afterselldetail.amount, barcode: @afterselldetail.barcode, bundle: @afterselldetail.bundle, cdate: @afterselldetail.cdate, color: @afterselldetail.color, discount: @afterselldetail.discount, goodsname: @afterselldetail.goodsname, hprice: @afterselldetail.hprice, inprice: @afterselldetail.inprice, outprice: @afterselldetail.outprice, pfprice: @afterselldetail.pfprice, pid: @afterselldetail.pid, ramount: @afterselldetail.ramount, rbundle: @afterselldetail.rbundle, remark: @afterselldetail.remark, size: @afterselldetail.size, status: @afterselldetail.status, stid: @afterselldetail.stid, stname: @afterselldetail.stname, subtotal: @afterselldetail.subtotal, tid: @afterselldetail.tid, type: @afterselldetail.type, unit: @afterselldetail.unit, volume: @afterselldetail.volume }
    assert_redirected_to afterselldetail_path(assigns(:afterselldetail))
  end

  test "should destroy afterselldetail" do
    assert_difference('Afterselldetail.count', -1) do
      delete :destroy, id: @afterselldetail
    end

    assert_redirected_to afterselldetails_path
  end
end
