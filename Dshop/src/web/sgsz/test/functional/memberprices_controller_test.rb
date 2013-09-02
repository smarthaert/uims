require 'test_helper'

class MemberpricesControllerTest < ActionController::TestCase
  setup do
    @memberprice = memberprices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:memberprices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create memberprice" do
    assert_difference('Memberprice.count') do
      post :create, memberprice: { barcode: @memberprice.barcode, cdate: @memberprice.cdate, color: @memberprice.color, custid: @memberprice.custid, custname: @memberprice.custname, custtel: @memberprice.custtel, enddate: @memberprice.enddate, goodsname: @memberprice.goodsname, hprice: @memberprice.hprice, pid: @memberprice.pid, remark: @memberprice.remark, size: @memberprice.size, startdate: @memberprice.startdate, unit: @memberprice.unit, volume: @memberprice.volume }
    end

    assert_redirected_to memberprice_path(assigns(:memberprice))
  end

  test "should show memberprice" do
    get :show, id: @memberprice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @memberprice
    assert_response :success
  end

  test "should update memberprice" do
    put :update, id: @memberprice, memberprice: { barcode: @memberprice.barcode, cdate: @memberprice.cdate, color: @memberprice.color, custid: @memberprice.custid, custname: @memberprice.custname, custtel: @memberprice.custtel, enddate: @memberprice.enddate, goodsname: @memberprice.goodsname, hprice: @memberprice.hprice, pid: @memberprice.pid, remark: @memberprice.remark, size: @memberprice.size, startdate: @memberprice.startdate, unit: @memberprice.unit, volume: @memberprice.volume }
    assert_redirected_to memberprice_path(assigns(:memberprice))
  end

  test "should destroy memberprice" do
    assert_difference('Memberprice.count', -1) do
      delete :destroy, id: @memberprice
    end

    assert_redirected_to memberprices_path
  end
end
