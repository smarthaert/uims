require 'test_helper'

class SelllogmainsControllerTest < ActionController::TestCase
  setup do
    @selllogmain = selllogmains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:selllogmains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create selllogmain" do
    assert_difference('Selllogmain.count') do
      post :create, selllogmain: { aamount: @selllogmain.aamount, avolume: @selllogmain.avolume, cdate: @selllogmain.cdate, custaddr: @selllogmain.custaddr, custid: @selllogmain.custid, custname: @selllogmain.custname, custstate: @selllogmain.custstate, custtel: @selllogmain.custtel, nextid: @selllogmain.nextid, payment: @selllogmain.payment, pdate: @selllogmain.pdate, preid: @selllogmain.preid, remark: @selllogmain.remark, saddress: @selllogmain.saddress, shishou: @selllogmain.shishou, shopname: @selllogmain.shopname, shoukuan: @selllogmain.shoukuan, sid: @selllogmain.sid, slid: @selllogmain.slid, sname: @selllogmain.sname, status: @selllogmain.status, stel: @selllogmain.stel, stid: @selllogmain.stid, stname: @selllogmain.stname, type: @selllogmain.type, uid: @selllogmain.uid, uname: @selllogmain.uname, yingshou: @selllogmain.yingshou, zhaoling: @selllogmain.zhaoling }
    end

    assert_redirected_to selllogmain_path(assigns(:selllogmain))
  end

  test "should show selllogmain" do
    get :show, id: @selllogmain
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @selllogmain
    assert_response :success
  end

  test "should update selllogmain" do
    put :update, id: @selllogmain, selllogmain: { aamount: @selllogmain.aamount, avolume: @selllogmain.avolume, cdate: @selllogmain.cdate, custaddr: @selllogmain.custaddr, custid: @selllogmain.custid, custname: @selllogmain.custname, custstate: @selllogmain.custstate, custtel: @selllogmain.custtel, nextid: @selllogmain.nextid, payment: @selllogmain.payment, pdate: @selllogmain.pdate, preid: @selllogmain.preid, remark: @selllogmain.remark, saddress: @selllogmain.saddress, shishou: @selllogmain.shishou, shopname: @selllogmain.shopname, shoukuan: @selllogmain.shoukuan, sid: @selllogmain.sid, slid: @selllogmain.slid, sname: @selllogmain.sname, status: @selllogmain.status, stel: @selllogmain.stel, stid: @selllogmain.stid, stname: @selllogmain.stname, type: @selllogmain.type, uid: @selllogmain.uid, uname: @selllogmain.uname, yingshou: @selllogmain.yingshou, zhaoling: @selllogmain.zhaoling }
    assert_redirected_to selllogmain_path(assigns(:selllogmain))
  end

  test "should destroy selllogmain" do
    assert_difference('Selllogmain.count', -1) do
      delete :destroy, id: @selllogmain
    end

    assert_redirected_to selllogmains_path
  end
end
