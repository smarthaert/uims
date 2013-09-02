require 'test_helper'

class AftersellmainsControllerTest < ActionController::TestCase
  setup do
    @aftersellmain = aftersellmains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:aftersellmains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create aftersellmain" do
    assert_difference('Aftersellmain.count') do
      post :create, aftersellmain: { cdate: @aftersellmain.cdate, custaddr: @aftersellmain.custaddr, custid: @aftersellmain.custid, custname: @aftersellmain.custname, custstate: @aftersellmain.custstate, custtel: @aftersellmain.custtel, fukuan: @aftersellmain.fukuan, nextid: @aftersellmain.nextid, payment: @aftersellmain.payment, pdate: @aftersellmain.pdate, preid: @aftersellmain.preid, remark: @aftersellmain.remark, saddress: @aftersellmain.saddress, shishou: @aftersellmain.shishou, shitui: @aftersellmain.shitui, shopname: @aftersellmain.shopname, shoukuan: @aftersellmain.shoukuan, sid: @aftersellmain.sid, sname: @aftersellmain.sname, status: @aftersellmain.status, stel: @aftersellmain.stel, stid: @aftersellmain.stid, stname: @aftersellmain.stname, tid: @aftersellmain.tid, tpayment: @aftersellmain.tpayment, tremark: @aftersellmain.tremark, tuid: @aftersellmain.tuid, tuname: @aftersellmain.tuname, type: @aftersellmain.type, uid: @aftersellmain.uid, uname: @aftersellmain.uname, yingshou: @aftersellmain.yingshou, yingtui: @aftersellmain.yingtui, zhaohui: @aftersellmain.zhaohui, zhaoling: @aftersellmain.zhaoling }
    end

    assert_redirected_to aftersellmain_path(assigns(:aftersellmain))
  end

  test "should show aftersellmain" do
    get :show, id: @aftersellmain
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @aftersellmain
    assert_response :success
  end

  test "should update aftersellmain" do
    put :update, id: @aftersellmain, aftersellmain: { cdate: @aftersellmain.cdate, custaddr: @aftersellmain.custaddr, custid: @aftersellmain.custid, custname: @aftersellmain.custname, custstate: @aftersellmain.custstate, custtel: @aftersellmain.custtel, fukuan: @aftersellmain.fukuan, nextid: @aftersellmain.nextid, payment: @aftersellmain.payment, pdate: @aftersellmain.pdate, preid: @aftersellmain.preid, remark: @aftersellmain.remark, saddress: @aftersellmain.saddress, shishou: @aftersellmain.shishou, shitui: @aftersellmain.shitui, shopname: @aftersellmain.shopname, shoukuan: @aftersellmain.shoukuan, sid: @aftersellmain.sid, sname: @aftersellmain.sname, status: @aftersellmain.status, stel: @aftersellmain.stel, stid: @aftersellmain.stid, stname: @aftersellmain.stname, tid: @aftersellmain.tid, tpayment: @aftersellmain.tpayment, tremark: @aftersellmain.tremark, tuid: @aftersellmain.tuid, tuname: @aftersellmain.tuname, type: @aftersellmain.type, uid: @aftersellmain.uid, uname: @aftersellmain.uname, yingshou: @aftersellmain.yingshou, yingtui: @aftersellmain.yingtui, zhaohui: @aftersellmain.zhaohui, zhaoling: @aftersellmain.zhaoling }
    assert_redirected_to aftersellmain_path(assigns(:aftersellmain))
  end

  test "should destroy aftersellmain" do
    assert_difference('Aftersellmain.count', -1) do
      delete :destroy, id: @aftersellmain
    end

    assert_redirected_to aftersellmains_path
  end
end
