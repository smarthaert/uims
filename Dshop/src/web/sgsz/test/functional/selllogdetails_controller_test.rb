require 'test_helper'

class SelllogdetailsControllerTest < ActionController::TestCase
  setup do
    @selllogdetail = selllogdetails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:selllogdetails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create selllogdetail" do
    assert_difference('Selllogdetail.count') do
      post :create, selllogdetail: { additional: @selllogdetail.additional, amount: @selllogdetail.amount, barcode: @selllogdetail.barcode, bundle: @selllogdetail.bundle, camount: @selllogdetail.camount, cbundle: @selllogdetail.cbundle, cdate: @selllogdetail.cdate, color: @selllogdetail.color, discount: @selllogdetail.discount, goodsname: @selllogdetail.goodsname, hprice: @selllogdetail.hprice, inprice: @selllogdetail.inprice, outprice: @selllogdetail.outprice, pdate: @selllogdetail.pdate, pfprice: @selllogdetail.pfprice, pid: @selllogdetail.pid, remark: @selllogdetail.remark, size: @selllogdetail.size, slid: @selllogdetail.slid, status: @selllogdetail.status, stid: @selllogdetail.stid, stname: @selllogdetail.stname, store: @selllogdetail.store, subtotal: @selllogdetail.subtotal, type: @selllogdetail.type, unit: @selllogdetail.unit, volume: @selllogdetail.volume }
    end

    assert_redirected_to selllogdetail_path(assigns(:selllogdetail))
  end

  test "should show selllogdetail" do
    get :show, id: @selllogdetail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @selllogdetail
    assert_response :success
  end

  test "should update selllogdetail" do
    put :update, id: @selllogdetail, selllogdetail: { additional: @selllogdetail.additional, amount: @selllogdetail.amount, barcode: @selllogdetail.barcode, bundle: @selllogdetail.bundle, camount: @selllogdetail.camount, cbundle: @selllogdetail.cbundle, cdate: @selllogdetail.cdate, color: @selllogdetail.color, discount: @selllogdetail.discount, goodsname: @selllogdetail.goodsname, hprice: @selllogdetail.hprice, inprice: @selllogdetail.inprice, outprice: @selllogdetail.outprice, pdate: @selllogdetail.pdate, pfprice: @selllogdetail.pfprice, pid: @selllogdetail.pid, remark: @selllogdetail.remark, size: @selllogdetail.size, slid: @selllogdetail.slid, status: @selllogdetail.status, stid: @selllogdetail.stid, stname: @selllogdetail.stname, store: @selllogdetail.store, subtotal: @selllogdetail.subtotal, type: @selllogdetail.type, unit: @selllogdetail.unit, volume: @selllogdetail.volume }
    assert_redirected_to selllogdetail_path(assigns(:selllogdetail))
  end

  test "should destroy selllogdetail" do
    assert_difference('Selllogdetail.count', -1) do
      delete :destroy, id: @selllogdetail
    end

    assert_redirected_to selllogdetails_path
  end
end
