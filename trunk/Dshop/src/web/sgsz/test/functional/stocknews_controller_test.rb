require 'test_helper'

class StocknewsControllerTest < ActionController::TestCase
  setup do
    @stocknews = stocknews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stocknews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stocknews" do
    assert_difference('Stocknew.count') do
      post :create, stocknews: { amount: @stocknews.amount, color: @stocknews.color, goodsname: @stocknews.goodsname, pid: @stocknews.pid, unit: @stocknews.unit, volume: @stocknews.volume }
    end

    assert_redirected_to stocknews_path(assigns(:stocknews))
  end

  test "should show stocknews" do
    get :show, id: @stocknews
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stocknews
    assert_response :success
  end

  test "should update stocknews" do
    put :update, id: @stocknews, stocknews: { amount: @stocknews.amount, color: @stocknews.color, goodsname: @stocknews.goodsname, pid: @stocknews.pid, unit: @stocknews.unit, volume: @stocknews.volume }
    assert_redirected_to stocknews_path(assigns(:stocknews))
  end

  test "should destroy stocknews" do
    assert_difference('Stocknew.count', -1) do
      delete :destroy, id: @stocknews
    end

    assert_redirected_to stocknews_path
  end
end
