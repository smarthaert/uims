require 'test_helper'

class BuylogsControllerTest < ActionController::TestCase
  setup do
    @buylog = buylogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buylogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create buylog" do
    assert_difference('Buylog.count') do
      post :create, buylog: { bz: @buylog.bz, cdate: @buylog.cdate, cpbh: @buylog.cpbh, cpmc: @buylog.cpmc, dj: @buylog.dj, js: @buylog.js, remark: @buylog.remark, sl: @buylog.sl, tj: @buylog.tj, uid: @buylog.uid, uname: @buylog.uname, utel: @buylog.utel, xj: @buylog.xj, yfbz: @buylog.yfbz, ys: @buylog.ys }
    end

    assert_redirected_to buylog_path(assigns(:buylog))
  end

  test "should show buylog" do
    get :show, id: @buylog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @buylog
    assert_response :success
  end

  test "should update buylog" do
    put :update, id: @buylog, buylog: { bz: @buylog.bz, cdate: @buylog.cdate, cpbh: @buylog.cpbh, cpmc: @buylog.cpmc, dj: @buylog.dj, js: @buylog.js, remark: @buylog.remark, sl: @buylog.sl, tj: @buylog.tj, uid: @buylog.uid, uname: @buylog.uname, utel: @buylog.utel, xj: @buylog.xj, yfbz: @buylog.yfbz, ys: @buylog.ys }
    assert_redirected_to buylog_path(assigns(:buylog))
  end

  test "should destroy buylog" do
    assert_difference('Buylog.count', -1) do
      delete :destroy, id: @buylog
    end

    assert_redirected_to buylogs_path
  end
end
