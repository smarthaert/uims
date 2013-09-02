require 'test_helper'

class OrdermainsControllerTest < ActionController::TestCase
  setup do
    @ordermain = ordermains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ordermains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ordermain" do
    assert_difference('Ordermain.count') do
      post :create, ordermain: { canal: @ordermain.canal, cdate: @ordermain.cdate, custaddr: @ordermain.custaddr, custid: @ordermain.custid, custname: @ordermain.custname, custstate: @ordermain.custstate, custtel: @ordermain.custtel, nextid: @ordermain.nextid, oid: @ordermain.oid, payment: @ordermain.payment, preid: @ordermain.preid, remark: @ordermain.remark, saddress: @ordermain.saddress, shishou: @ordermain.shishou, shopname: @ordermain.shopname, sid: @ordermain.sid, sname: @ordermain.sname, status: @ordermain.status, stel: @ordermain.stel, type: @ordermain.type, uid: @ordermain.uid, uname: @ordermain.uname, yingshou: @ordermain.yingshou }
    end

    assert_redirected_to ordermain_path(assigns(:ordermain))
  end

  test "should show ordermain" do
    get :show, id: @ordermain
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ordermain
    assert_response :success
  end

  test "should update ordermain" do
    put :update, id: @ordermain, ordermain: { canal: @ordermain.canal, cdate: @ordermain.cdate, custaddr: @ordermain.custaddr, custid: @ordermain.custid, custname: @ordermain.custname, custstate: @ordermain.custstate, custtel: @ordermain.custtel, nextid: @ordermain.nextid, oid: @ordermain.oid, payment: @ordermain.payment, preid: @ordermain.preid, remark: @ordermain.remark, saddress: @ordermain.saddress, shishou: @ordermain.shishou, shopname: @ordermain.shopname, sid: @ordermain.sid, sname: @ordermain.sname, status: @ordermain.status, stel: @ordermain.stel, type: @ordermain.type, uid: @ordermain.uid, uname: @ordermain.uname, yingshou: @ordermain.yingshou }
    assert_redirected_to ordermain_path(assigns(:ordermain))
  end

  test "should destroy ordermain" do
    assert_difference('Ordermain.count', -1) do
      delete :destroy, id: @ordermain
    end

    assert_redirected_to ordermains_path
  end
end
