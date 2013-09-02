require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  setup do
    @purchase = purchases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase" do
    assert_difference('Purchase.count') do
      post :create, purchase: { bz: @purchase.bz, cdate: @purchase.cdate, cpbh: @purchase.cpbh, cpmc: @purchase.cpmc, dj: @purchase.dj, js: @purchase.js, remark: @purchase.remark, sl: @purchase.sl, tj: @purchase.tj, xj: @purchase.xj, yfbz: @purchase.yfbz, ys: @purchase.ys }
    end

    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should show purchase" do
    get :show, id: @purchase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase
    assert_response :success
  end

  test "should update purchase" do
    put :update, id: @purchase, purchase: { bz: @purchase.bz, cdate: @purchase.cdate, cpbh: @purchase.cpbh, cpmc: @purchase.cpmc, dj: @purchase.dj, js: @purchase.js, remark: @purchase.remark, sl: @purchase.sl, tj: @purchase.tj, xj: @purchase.xj, yfbz: @purchase.yfbz, ys: @purchase.ys }
    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should destroy purchase" do
    assert_difference('Purchase.count', -1) do
      delete :destroy, id: @purchase
    end

    assert_redirected_to purchases_path
  end
end
